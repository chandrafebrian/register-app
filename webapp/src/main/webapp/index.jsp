<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Site Reliability Engineer Registration</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .registration-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .registration-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            color: #666;
            font-size: 16px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .password-requirements {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }

        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .divider {
            margin: 25px 0;
            text-align: center;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e1e5e9;
        }

        .divider span {
            background: white;
            padding: 0 20px;
            color: #6c757d;
            font-size: 14px;
        }

        .signin-link {
            text-align: center;
            margin-top: 20px;
        }

        .signin-link p {
            color: #666;
            font-size: 14px;
        }

        .signin-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .signin-link a:hover {
            text-decoration: underline;
        }

        .terms {
            font-size: 13px;
            color: #6c757d;
            text-align: center;
            margin: 20px 0;
            line-height: 1.4;
        }

        .terms a {
            color: #667eea;
            text-decoration: none;
        }

        .terms a:hover {
            text-decoration: underline;
        }

        .footer-info {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }

        .footer-info .project-title {
            font-size: 14px;
            color: #495057;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .footer-info .contact-info {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 3px;
        }

        @media (max-width: 600px) {
            .registration-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>
    <div class="registration-container">
        <div class="header">
            <h1>Site Reliability Engineer</h1>
            <p>Create your professional account to get started</p>
        </div>

        <form action="action_page.php" method="POST">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" class="form-control" placeholder="Enter your full name" name="fullName" id="fullName"
                    required>
            </div>

            <div class="form-group">
                <label for="mobile">Mobile Number</label>
                <input type="tel" class="form-control" placeholder="Enter your mobile number" name="mobile" id="mobile"
                    pattern="[0-9]{10,15}" required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" class="form-control" placeholder="Enter your email address" name="email" id="email"
                    required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" placeholder="Create a secure password" name="password"
                    id="password" minlength="8" required>
                <div class="password-requirements">
                    Password must be at least 8 characters long
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" class="form-control" placeholder="Confirm your password" name="confirmPassword"
                    id="confirmPassword" required>
            </div>

            <div class="terms">
                By creating an account, you agree to our
                <a href="#" onclick="alert('Terms & Privacy policy would be displayed here')">Terms of Service</a>
                and
                <a href="#" onclick="alert('Privacy policy would be displayed here')">Privacy Policy</a>
            </div>

            <button type="submit" class="submit-btn">Create Account</button>
        </form>

        <div class="divider">
            <span>or</span>
        </div>

        <div class="signin-link">
            <p>Already have an account? <a href="#" onclick="alert('Sign in page would be displayed here')">Sign In</a>
            </p>
        </div>

        <div class="footer-info">
            <div class="project-title">Chandra Febrian - SRE Projects</div>
            <div class="contact-info">chandrafebrian99@gmail.com</div>
            <div class="contact-info">Mini Project 2025</div>
        </div>
    </div>

    <script>
        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function () {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;

            if (password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });

        // Form submission enhancement
        document.querySelector('form').addEventListener('submit', function (e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match. Please check and try again..');
                return false;
            }
        });
    </script>
</body>

</html>