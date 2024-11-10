<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="controleur.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <%
        int unePage = 0;
        if (request.getParameter("page") != null) {
            unePage = Integer.parseInt(request.getParameter("page"));
        }
        
        switch (unePage) {
        	case 0:
        		%> <%@ include file="home.jsp" %> <%
        		break;
            case 1:
                %> <%@ include file="faq.jsp" %> <%
                break;
            case 2:
                %> <%@ include file="create-ticket.jsp" %> <%
                break;
            case 3:
                %> <%@ include file="see-ticket.jsp" %> <%
                break;
        }
    %>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
