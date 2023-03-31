from string import punctuation
from flask import redirect, session
from email_validator import validate_email, EmailNotValidError
from functools import wraps

def validate_pass(password, confirmation):
    """Validates user-submitted password"""
    # Password and confirmation match
    if password != confirmation:
        return "Passwords do not match"
    
    # no space
    if ' ' in password:
        return "Password can not include spaces"
    
    # length
    if len(password) < 8:
        return "Password should be at least 8 characters"
    
    # at least 1 special character
    special_chars = [True for x in password if x in punctuation]
    if len(special_chars) == 0:
        return "Password should contain at least 1 special character"
    
    # at least 1 number
    nums = any(x.isdigit() for x in password)
    if not nums:
        return "Password should contain at least 1 number"
    
    return True

def login_required(f):
    """
    Decorate routes to require login.

    https://flask.palletsprojects.com/en/1.1.x/patterns/viewdecorators/
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)
    return decorated_function
 
def check_email(email):
    """Checks Email Format"""
    try:
      # validate and get info
        v = validate_email(email)
        return True
        
    except EmailNotValidError as e:
        # email is not valid, exception message is human-readable
        return str(e)