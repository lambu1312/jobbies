<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="main-content">
    <div class="deactivate-card">
        <h6>Deactivate Your Account</h6>
        <p>Are you sure you want to deactivate your account?</p>

        <c:if test="${requestScope.error != null}">
            <div class="alert alert-danger text-center">
                ${requestScope.error}
            </div>
        </c:if>

        <c:if test="${requestScope.message != null}">
            <div class="alert alert-success text-center">
                ${requestScope.message}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/authen?action=deactivate-account" method="POST">
            <div class="mb-3">
                <label for="currentPassword" class="form-label">Please Enter Your Login Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword"
                           placeholder="Enter your password" required onkeydown="preventSpaces(event)">
                    <span class="input-group-text" onclick="togglePasswordVisibility('currentPassword')">👁️</span>
                </div>
            </div>

            <p class="text-danger">
                <strong>Note:</strong> After your account is deactivated, you will temporarily be unable to use it.
                If you wish to reactivate your account, please contact the Admin for assistance.
            </p>

            <div class="btn-group">
                <button type="button" class="btn btn-primary" onclick="cancelDeactivation()">Cancel</button>
                <button type="submit" class="btn btn-danger">Deactivate Account</button>
            </div>
        </form>
    </div>
</div>

<script>
    function togglePasswordVisibility(id) {
        const passwordField = document.getElementById(id);
        passwordField.type = (passwordField.type === 'password') ? 'text' : 'password';
    }

    function preventSpaces(event) {
        if (event.key === " ") {
            event.preventDefault();
            alert("Passwords cannot contain spaces.");
        }
    }

    function cancelDeactivation() {
        window.history.back();
    }
</script>
