import unittest, tempfile
from app import app, db
from werkzeug.security import generate_password_hash

class AuthTestCase(unittest.TestCase):
    def setUp(self):
        self.db_fd, app.config['DATABASE'] = tempfile.mkstemp()
        app.config['TESTING'] = True
        app.config["SESSION_COOKIE_NAME"] = "e47nly_session_cookie"
        self.app = app.test_client()
        self.test_id = db.execute("INSERT INTO ev_owners (email, password, fullname, phone_number, birthdate, vehicle) VALUES (?, ?, ?, ?, ?, ?)",
                                            'test@test.com', generate_password_hash('password'), 'Test User', 
                                            '123-456-7890', '01/01/2000', 'Tesla Model S')

    def tearDown(self):
        db.execute("DELETE FROM ev_owners WHERE email = 'newuser@test.com'")
        db.execute("DELETE FROM ev_owners WHERE email = 'test@test.com'")

    def test_login(self):
        # Test Valid Login
        response = self.app.post('/login/ev_owners', data=dict(
            email='test@test.com',
            password='password'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)

        # Test Wrong Password
        response = self.app.post('/login/ev_owners', data=dict(
            email='test@test.com',
            password='wrongpassword'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 401)
        self.assertTrue(b'Invalid email or password' in response.data)

        # Test invalid email
        response = self.app.post('/login/ev_owners', data=dict(
            email='wrongemail@test.com',
            password='password'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 401)
        self.assertTrue(b'Invalid email or password' in response.data)
    

    def test_register(self):

        # Test successful registration
        response = self.app.post('/register', data=dict(
            email='newuser@test.com',
            password='password#nkjs2',
            confirmation='password#nkjs2',
            fullname='New User',
            phone_number='555-555-5555',
            birthdate='02/02/2002',
            vehicle='Nissan Leaf'
        ), follow_redirects=True)

        self.assertEqual(response.status_code, 200)
        
        # Test registration with existing email/phone number
        response = self.app.post('/register', data=dict(
            email='test@test.com',
            password='password',
            confirmation='password',
            fullname='Test User',
            phone_number='123-456-7890',
            birthdate='01/01/2000',
            vehicle='Tesla Model S'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 400)
        self.assertTrue(b'Email/phone number already exists' in response.data)
        

        # Test registration with mismatched passwords
        response = self.app.post('/register', data=dict(
            email='mismatch@test.com',
            password='password',
            confirmation='notpassword',
            fullname='New mismatch',
            phone_number='555-555-38923',
            birthdate='02/02/2002',
            vehicle='Nissan Leaf'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 400)
        print(response.data)
        self.assertTrue(b'do not match' in response.data)
        
        
        # Test registration with invalid password
        response = self.app.post('/register', data=dict(
            email='tiny@test.com',
            password='weak',
            confirmation='weak',
            fullname='New small Pass',
            phone_number='555-988-5555',
            birthdate='02/02/2002',
            vehicle='Nissan Leaf'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 400)
        self.assertTrue(b'Password should be at least 8 characters' in response.data)
        
    def test_login_logout(self):
        # Test successful login
        response = self.app.post('/login/ev_owners', data=dict(
            email='test@test.com',
            password='password'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        
        # Test login with invalid email
        response = self.app.post('/login/ev_owners', data=dict(
            email='notanemail',
            password='password'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 401)
        self.assertTrue(b'Invalid email or password' in response.data)
        
        # Test login with invalid password
        response = self.app.post('/login/ev_owners', data=dict(
            email='test@test.com',
            password='wrongpassword'
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 401)
        self.assertTrue(b'Invalid email or password' in response.data)
        
        # Test logout
        response = self.app.get('/logout', follow_redirects=True)
        self.assertEqual(response.status_code, 200)
    

    def test_identify(self):

        # Test identifying a user that exists
        response = self.app.get(f'/identify/ev_owners/{self.test_id}', follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        self.assertTrue(b'"vehicle":"Tesla Model S"' in response.data)
        
        # Test identifying a user that doesn't exist
        response = self.app.get('/identify/ev_owners/1000', follow_redirects=True)
        self.assertEqual(response.status_code, 400)
        self.assertTrue(b'Invalid ID' in response.data)
        
        # Test identifying a user with an invalid mode
        response = self.app.get('/identify/invalid_mode/1', follow_redirects=True)
        self.assertEqual(response.status_code, 401)
        self.assertTrue(b'Invalid Mode' in response.data)


if __name__ == "__main__":
    unittest.main()