<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post">
    <input name="id" type="hidden" required value="${product.id}">
    <label>Tên sản phẩm:</label>
    <input name="computerName" required value="${product.computerName}">
    <label>Năm sản xuất:</label>
    <input name="releaseYear" required value="${product.releaseYear}">
    <label>Giá:</label>
    <input name="price" required value="${product.price}">
    <label>Số lượng:</label>
    <input name="quantity" required value="${product.quantity}">
    <label>Nhà sản xuất:</label>
    <input name="manufacturer" required value="${product.manufacturer}">
    <label>Trạng thái:</label>
    <input name="status" required value="${product.status}">
    <label>Loại máy tính:</label>
    <select name="categoryId">
        <option value="0">Chọn loại</option>
        <c:forEach var="category" items="${categories}">
            <option value="${category.id}" <c:if test="${product.categoryId == category.id}">selected</c:if>>
                    ${category.categoryName}
            </option>
        </c:forEach>
    </select>
    <button type="submit">Chỉnh sửa</button>
</form>
</body>
</html>
