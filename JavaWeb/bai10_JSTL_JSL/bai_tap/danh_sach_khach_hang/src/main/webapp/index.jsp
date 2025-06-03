<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1>Danh sách khách hàng</h1>
<table>
    <tr>
        <th>Tên</th>
        <th>Ngày sinh</th>
        <th>Địa chỉ</th>
        <th>Ảnh</th>
    </tr>

    <c:forEach var="item" items="${user}" varStatus="index">
        <tr>
            <td>${index.count}</td>
            <td>${item.name}</td>
            <td>${item.dateOfBirth}</td>
            <td>${item.address}</td>
            <td><img src="${item.img}" alt=""></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>