<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">

<jsp:include page="fragments/headTag.jsp"/>

<body>
<H1>hello {{welcome.message}}</H1>
<div class="container">
    <jsp:include page="fragments/bodyHeader.jsp"/>
    <h2><fmt:message key="welcome"/></h2>
    <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
    <img src="${petsImage}"/>

    <jsp:include page="fragments/footer.jsp"/>

</div>
</body>

</html>
