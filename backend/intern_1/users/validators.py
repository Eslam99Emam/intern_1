import re
from django.contrib.auth.password_validation import validate_password as base_validate_password
from email_validator import validate_email as base_validate_email
from .exceptions import *

def validate_password(value: str):
    base_validate_password(value)

    if len(value) < 10:
        raise ValidationError("Password must be at least 10 characters.")

    if not re.search(r"[A-Z]", value):
        raise ValidationError("Password must contain an uppercase letter.")

    if not re.search(r"[a-z]", value):
        raise ValidationError("Password must contain a lowercase letter.")

    if not re.search(r"\d", value):
        raise ValidationError("Password must contain a number.")

    if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", value):
        raise ValidationError("Password must contain a special character.")

    return value


def validate_email(value: str):
    from users.models import User
    """
    Highly secure, simple email validation, no dependencies.
    Raises ValidationError if invalid.
    """
    if not isinstance(value, str) or not value:
        raise ValidationError("Email must be a non-empty string")

    # Trim whitespace
    value = value.strip()

    # Max length (RFC 5321: 254 chars)
    if len(value) > 254:
        raise ValidationError("Email is too long")

    # Basic regex: local@domain.tld
    pattern = r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
    if not re.match(pattern, value):
        raise ValidationError("Invalid email format")
    # No consecutive dots
    if ".." in value:
        raise ValidationError("Email cannot contain consecutive dots")

    # Domain and local part length limits
    local_part, domain_part = value.rsplit("@", 1)
    if len(local_part) > 64:
        raise ValidationError("Local part is too long")
    if len(domain_part) > 255:
        raise ValidationError("Domain part is too long")


    if User.objects.filter(email=value).exists():
        raise EmailConflictError("Email already exists")

    return value

def validate_phone(value: str):
    # 1) Remove leading + only (لو موجودة)
    if value.startswith("+"):
        cleaned = value[1:]
    else:
        cleaned = value

    # 2) Must be digits only
    if not cleaned.isdigit():
        raise ValidationError("Phone number must contain digits only.")

    # 3) Length constraints (international standard E.164)
    # Valid range: 8 → 15 digits
    if len(cleaned) < 8 or len(cleaned) > 15:
        raise ValidationError("Phone number length is invalid.")

    # 4) Optional: prevent numbers starting with '00' (weak formatting)
    if cleaned.startswith("00"):
        raise ValidationError("Phone number should not start with '00'.")

    # If all good → return normalized phone
    return value