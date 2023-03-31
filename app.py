from flask import Flask, request, session, redirect, url_for, jsonify
from flask_session import Session
from flask_mail import Mail, Message
from werkzeug.security import check_password_hash, generate_password_hash
from helpers import check_email, login_required, validate_pass
from secrets import token_hex
from datetime import datetime, timedelta
from cs50 import SQL
import os, logging

app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies) and mail server
app.config["SECRET_KEY"] = os.environ.get("FLASK_SECRET_KEY")
app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_PORT"] = 465
app.config["MAIL_USERNAME"] = "m.gomaa.abd@gmail.com"
app.config["MAIL_PASSWORD"] = "password"
app.config["MAIL_USE_TLS"] = False
app.config["MAIL_USE_SSL"] = True
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.config["SESSION_COOKIE_NAME"] = "e47nly_session_cookie"


# configure logger
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s %(levelname)s: %(message)s')
file_handler = logging.FileHandler('app.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

mail = Mail(app)
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///e47nly.db")

@app.route("/")
def index():
    """Main Page"""
    
    id = session.get("user_id")
    mode = session.get("mode")
    if not id:

        return jsonify(text="Hello E47nly. You ain't logged in.")
    
    return jsonify(id=id, mode=mode)

@app.route("/login/<mode>", methods=["GET", "POST"])
def login(mode):
    """Log user in"""

    # Forget any user_id
    session.clear()

    if mode not in ["ev_owners", "charger_owners"]:
            response = jsonify(error="Invalid Mode")
            response.status_code = 401
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response
    
    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        
       # Ensure email and password were submitted
        email = request.form.get("email")
        password = request.form.get("password")

        if not email or not password:
            response = jsonify(error="Please provide email and password")
            response.status_code = 400
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # Query database for user by email
        user = db.execute("SELECT * FROM ? WHERE email = ?", mode, email)

        # Check if user exists and password is correct
        if not user or not check_password_hash(user[0]["password"], password):
            response = jsonify(error="Invalid email or password")
            response.status_code = 401
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # Remember which user has logged in
        session["mode"] = mode
        session["user_id"] = user[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return jsonify(message="TODO: Flutter")

@app.route("/logout")
def logout():
    """Log user out"""
    
    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")

@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""

    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure email was submitted
        mail_check = check_email(request.form.get("email"))
        if not mail_check:
            response = jsonify(error=mail_check)
            response.status_code = 400
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # Query database for email to see if it's unique
        if len(db.execute("SELECT * FROM ev_owners WHERE email = ? or phone_number = ?", request.form.get("email"), request.form.get("phone_number"))) != 0:
            response = jsonify(error="Email/phone number already exists")
            response.status_code = 400
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # Password Validation
        pass_check = validate_pass(request.form.get("password"), request.form.get("confirmation"))
        if pass_check != True:
            response = jsonify(error=pass_check)
            response.status_code = 400
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # hashes the password and inserts user into database
        hashed = generate_password_hash(request.form.get("password"))

        # Remember which user has logged in
        try:
            session["user_id"] = db.execute("INSERT INTO ev_owners (email, password, fullname, phone_number, birthdate, vehicle) VALUES (?, ?, ?, ?, ?, ?)",
                                            request.form.get("email"), hashed, request.form.get("fullname"), request.form.get("phone_number"),
                                            request.form.get("birthdate"), request.form.get("vehicle"))
        except:
            response = jsonify(error="Error occurred while registering")
            response.status_code = 500
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    return jsonify(message="TODO: Flutter Register Page")

@app.route("/forgot_password/<mode>", methods=["GET", "POST"])
def forgot_password(mode):
    """Handles forgotten passwords"""

    if request.method == "POST":
        email = request.form["email"]
        # Check if email exists in the database
        if len(db.execute("SELECT * FROM ? WHERE email = ?", mode, email)) == 1:

            # Generate a random password reset token
            token = token_hex(16)

            # Set the expiration time to 30 minutes from now
            expiry_time = datetime.now() + timedelta(minutes=30)

            # Save the token and expiration time to the database
            db.execute("INSERT INTO reset_tokens (email, token, expiry_time) VALUES (?, ?, ?)",
                        email, token, expiry_time)            

            # Send an email with a password reset link
            msg = Message("Password Reset Request", sender="noreply@e47nly.com", recipients=[email])
            msg.body = f"""Hi! You recently requested to reset your E47nly Account Password.
            To reset your password, visit the following link:
{url_for('reset_password', mode="ev_owners", token=token, _external=True)} This link is valid for 30 minutes only.

If you did not make this request then simply ignore this email and no changes will be made.

Yours,
E47nly Team
"""
            mail.send(msg)
            return redirect("/login")
        
    return jsonify(message="TODO: Forgot Password Flutter")

@app.route("/reset_password/<mode>/<token>", methods=["GET", "POST"])
def reset_password(mode, token):
    """Resets password using reset tokens"""
    if request.method == 'POST':
        user = db.execute("SELECT * FROM reset_tokens WHERE token = ?", token)[0]

        if datetime.fromisoformat(user['expiry_time']) <= datetime.now():
            return f"This token has expired at {datetime.fromisoformat(user['expiry_time'])}"
        
        email = user["email"]

        # Password Validation
        check = validate_pass(request.form.get("password"), request.form.get("confirmation"))
        if check != True:
            response = jsonify(message=check)
            response.status_code = 401
            logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
            return response

        # hashes the password and inserts user into database
        hashed = generate_password_hash(request.form.get("password"))
        db.execute('UPDATE ? SET password = ? WHERE email = ?', mode, hashed, email)
        db.execute('UPDATE reset_tokens SET expiry_time = ? WHERE email = ?', datetime.now(), email)

        return redirect("/login")

    return jsonify(message="TODO: Flutter Reset Password")


@app.route("/request_charge", methods=["POST"])
@login_required
def request_charge():
    """Request a charge"""
    charger_id = request.form.get("charger_id")
    current_time = datetime.now()

    id = db.execute("INSERT INTO charges (ev_owner_id, charger_id, request_time, status) VALUES (?, ?, ?, ?)",
                   session["user_id"], charger_id, current_time, "requested")
    
    return jsonify(id=id, sess=session["user_id"])


@app.route("/identify/<mode>/<int:id>")
def identify(mode, id):
    """Queries the database for user using id"""

    # Add authentication check here
    ...

    if mode not in ["ev_owners", "charger_owners"]:
        response = jsonify(error="Invalid Mode")
        response.status_code = 401
        logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
        return response
    
    try:
        # Returns everything except mail and password
        profile = db.execute("SELECT id, fullname, phone_number, birthdate, vehicle FROM ? WHERE id = ?", mode, id)[0]
        profile.pop("password", None)
        return jsonify(profile)
    
    except:
        response = jsonify(error="Invalid ID")
        response.status_code = 400
        logger.error(f"Error in {request.method} {request.url}: {response.status_code}")
        return response


if __name__ == "__main__":
    app.run(debug=True, threaded=False)
    #flask run --host=0.0.0.0
    """
    --host: Specifies the network interface to bind to (default is 127.0.0.1).
    --port: Specifies the port to bind to (default is 5000).
    --debug: Enables debug mode. This is useful for development, but should not be used in production.
    --reload: Enables automatic reloading of the server when code changes are detected. This is useful for development.
    --ssl-cert: Path to the SSL certificate file to use for HTTPS.
    --ssl-key: Path to the SSL key file to use for HTTPS.
    """