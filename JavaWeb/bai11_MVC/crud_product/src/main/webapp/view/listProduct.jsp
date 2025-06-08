<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>listProduct</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
</head>
<body>
<div style="display: flex;justify-content: start;">
    <button style="border: 1px solid black">
        <a href="product?action=create" style="color: black;text-decoration: none;">Thêm mới</a>
    </button>
    <form action="product" method="get">
        <input type="text" name="keyword" placeholder="Enter name you want to search" value="${keyword}">
        <select name="categoryId" id="">
            <option value="0">Chọn loại</option>
            <c:forEach var="category" items="${categories}">
                <option value="${category.id}"
                        <c:if test="${category.id==selectedCategoryId}">selected</c:if>>${category.categoryName}</option>
            </c:forEach>
        </select>
        <input type="hidden" name="action" value="filter">
        <button type="submit">Search</button>
    </form>
</div>

<span style="color:red">${param.mess}</span>
<table border="1px">
    <tr>
        <th>STT</th>
        <th>Tên Sản Phẩm</th>
        <th>Năm sản xuất</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Nhà sản xuất</th>
        <th>Trạng thái</th>
        <th>Loại hàng</th>
        <th>Chỉnh sửa</th>
        <th>Xóa</th>
    </tr>

    <c:forEach var="product" varStatus="idx" items="${products}">
        <tr>
            <td>${idx.count}</td>
            <td>${product.computerName}</td>
            <td>${product.releaseYear}</td>
            <td>${product.price}</td>
            <td>${product.quantity}</td>
            <td>${product.manufacturer}</td>
            <td>${product.status}</td>
            <td>${product.categoryId}</td>
            <td>
                <a href="product?action=update&id=${product.id}" class="btn btn-primary btn-sm">
                    Update
                </a>
            </td>
            <td>
                <button onclick="deleteInfo('${product.id}','${product.computerName}')" type="button"
                        class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Delete
                </button>
            </td>
        </tr>
    </c:forEach>
</table>
<div>
    <!-- Previous button -->
    <form action="product" method="get" style="display:inline;">
        <input type="hidden" name="pageNumber" value="${currentPage - 1}"/>
        <input type="hidden" name="categoryId" value="${selectedCategoryId}"/>
        <input type="hidden" name="keyword" value="${keyword}"/>
        <button type="submit" ${currentPage == 1 ? 'disabled' : ''}>Previous</button>
    </form>

    <!-- Current page button -->
    <button disabled style="font-weight:bold;color:red;">
        ${currentPage} / ${totalPages}
    </button>

    <!-- Next button -->
    <form action="product" method="get" style="display:inline;">
        <input type="hidden" name="pageNumber" value="${currentPage + 1}"/>
        <input type="hidden" name="categoryId" value="${selectedCategoryId}"/>
        <input type="hidden" name="keyword" value="${keyword}"/>
        <button type="submit" ${currentPage == totalPages ? 'disabled' : ''}>Next</button>
    </form>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="/product?action=delete">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input hidden="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn xoá sản phẩm </span><span id="deleteName"></span> không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button class="btn btn-primary">Xoá</button>
                </div>
            </div>
        </form>
    </div>
</div>
<c:if test="${not empty sessionScope.successMessage}">
    <script>
        alert("${sessionScope.successMessage}");
    </script>
    <c:remove var="successMessage" scope="session"/>
</c:if>
<script>
    function deleteInfo(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }
</script>
</body>
</html>
