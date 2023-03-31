from locust import HttpUser, task, between
from app import app, db

class TestLoad(HttpUser):
    wait_time = between(5, 10)
    app.config['TESTING'] = True
    app.config["SESSION_COOKIE_NAME"] = "e47nly_session_cookie"

    @task
    def test_home(self):
        self.client.get("/")
    
    @task
    def test_identify(self):
        
        # Test Valid Login
        self.client.post('/login/ev_owners', data=dict(
            email="mohamed.abdullah@ejust.edu.eg",
            password='@1000years'
        ))

        self.client.get("/identify/ev_owners/1")
        self.client.get("/logout")
    
    @task
    def test_register(self):
        self.client.get("/register")
    
# locust -f load_test.py --host=http://127.0.0.1:5000