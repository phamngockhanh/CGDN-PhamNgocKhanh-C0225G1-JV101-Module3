<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #66afe9;
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<form method="post" class="form-container">
    <h2>Thông tin sản phẩm</h2>

    <div class="form-group">
        <label>Tên sản phẩm:</label>
        <input name="computerName" required value="${product.computerName}">
        <span style="color: red">${error.get("computerName")}</span>
    </div>

    <div class="form-group">
        <label>Năm sản xuất:</label>
        <input name="releaseYear" required value="${product.releaseYear}">
        <span style="color: red">${error.get("year")}</span>
    </div>

    <div class="form-group">
        <label>Giá:</label>
        <input name="price" required value="${product.price}">
        <span style="color: red">${error.get("price")}</span>
    </div>

    <div class="form-group">
        <label>Số lượng:</label>
        <input name="quantity" required value="${product.quantity}">
        <span style="color: red">${error.get("quantity")}</span>
    </div>

    <div class="form-group">
        <label>Nhà sản xuất:</label>
        <input name="manufacturer" required value="${product.manufacturer}">
        <span style="color: red">${error.get("manufacturer")}</span>
    </div>

    <div class="form-group">
        <label>Trạng thái:</label>
        <select name="status" required>
            <option value="true" <c:if test="${product.status == true}">selected</c:if>>True</option>
            <option value="false" <c:if test="${product.status == false}">selected</c:if>>False</option>
        </select>
    </div>

    <div class="form-group">
        <label>Loại máy tính:</label>
        <select name="categoryId" required>
            <option value="0">Chọn loại máy tính</option>
            <c:forEach var="category" items="${categories}">
                <option value="${category.id}"
                        <c:if test="${category.id == product.categoryId}">selected</c:if>   >${category.categoryName}</option>
            </c:forEach>
        </select>
        <span style="color: red">${error.get("categoryId")}</span>
    </div>

    <button type="submit">Tạo</button>
</form>
</body>
</html>
