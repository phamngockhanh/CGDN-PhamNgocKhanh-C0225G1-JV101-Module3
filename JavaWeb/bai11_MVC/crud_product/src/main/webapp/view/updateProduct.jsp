<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="/product?action=update">
  <label>ID:</label>
  <input name="id" required value=${product.id}>
  <label>Tên sản phẩm:</label>
  <input name="nameProduct" required value=${product.nameProduct}>
  <label>Giá:</label>
  <input name="price" required value=${product.price}>
  <label>Chi tiết:</label>
  <input name="description" required value=${product.description}>
  <label>Nhà sản xuất:</label>
  <input name="manufacturer" required value=${product.manufacturer}>
  <button type="submit">Chỉnh sửa</button>
</form>
</body>
</html>
