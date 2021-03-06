<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wup" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="authenticatedUser" class="wup.data.User" scope="session" />
<c:if test="${authenticatedUser.email != null}">
    <% response.sendRedirect(request.getContextPath()); %>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>로그인 | WUP</title>
        <wup:includeAssets />
    </head>
    <body>
        <div id="app-main" class="app">
            <wup:appHeader />
            <main>
                <div class="modal-container">
                    <div class="contents">
                        <div id="signin-form" class="modal">
                            <div class="top-tabs">
                                <div class="tab active">로그인</div>
                                <div class="tab">사용자 등록</div>
                            </div>
                            <div class="contents">
                                <c:if test="${sessionScope.loginErrorMessage != null}">
                                    <div id="error-message" class="error-message">${sessionScope.loginErrorMessage}</div>
                                    <c:remove var="loginErrorMessage" scope="session" />
                                </c:if>
                                <form method="post" action="<c:url value="/processLogin" />" style="display: block">
                                    <div class="form-item">
                                        <input type="text" name="email" placeholder="이메일 주소">
                                    </div>
                                    <div class="form-item">
                                        <input type="password" name="password" placeholder="암호">
                                    </div>
                                    <div class="form-item">
                                        <input type="submit" value="로그인" class="tinted">
                                    </div>
                                </form>
                                <form method="post" action="<c:url value="/processJoin" />" style="display: none">
                                    <div class="form-item">
                                        <input type="text" name="email" placeholder="이메일 주소">
                                    </div>
                                    <div class="form-item">
                                        <input type="text" name="fullName" placeholder="이름">
                                    </div>
                                    <div class="form-item">
                                        <input type="text" name="nickname" placeholder="별명">
                                    </div>
                                    <div class="form-item">
                                        <input type="password" name="password" placeholder="암호">
                                    </div>
                                    <div class="form-item">
                                        <input type="password" name="passwordConfirm" placeholder="암호 확인">
                                    </div>
                                    <div class="form-item">
                                        <input type="submit" value="등록" class="tinted">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <div id="dropdown-container" class="dropdown-container"></div>
        </div>
        <script>
        (function() {
            let loginDialog = document.getElementById("signin-form");
            let tabContainer = loginDialog.getElementsByClassName("top-tabs")[0];
            let tabControl = new TopTabs(tabContainer);
            let forms = document.forms;
            let errMsg = document.getElementById("error-message");
            var loaded = false;

            tabControl.tabChanged = i => {
                for (var form of forms) {
                    form.style.display = "none";
                }

                forms[i].style.display = "block";

                if (errMsg && loaded) {
                    errMsg.style.display = "none";
                }
            };

            tabControl.setTab(location.hash === "#join" ? 1 : 0);

            loaded = true;
        })();
        </script>
    </body>
</html>