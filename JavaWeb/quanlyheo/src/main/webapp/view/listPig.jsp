<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Danh sách sản phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- DataTables CSS + JS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <style>
        /* Hover màu vàng nhạt */
        table.table-hover > tbody > tr:hover {
            background-color: #fff9c4 !important;
        }

        .form-control:focus {
            border-color: #ffc107 !important;
            box-shadow: 0 0 0 0.25rem rgba(255, 193, 7, 0.25);
        }

        .table-hover tbody tr:hover {
            background-color: #fff9c4 !important; /* vàng nhạt */
        }

        td button {
            border: none;
            background: none;
            padding: 0 4px;
        }

        td i:hover {
            color: #ffc107;
            cursor: pointer;
        }

    </style>
</head>
<body>
<h1 style="text-align: center;">Quản lý heo</h1>

<div class="d-flex justify-content-center">
    <div class="d-flex align-items-center gap-3 p-3 flex-wrap justify-content-center">

        <!-- Nút thêm mới -->
        <%--        <div class="d-flex gap-2">--%>
        <%--            <button onclick="window.location.href='/lesson?action=create'" type="button" class="btn btn-warning btn-sm">--%>
        <%--                Thêm mới bài học--%>
        <%--            </button>--%>
        <%--        </div>--%>

        <!-- Form tìm kiếm -->
        <form method="post" action="/pig"
              class="d-flex align-items-center gap-3 p-3 flex-wrap justify-content-center">
            <input type="hidden" name="action" value="search"/>
            <label>
                <select name="status" class="form-select form-select-sm" style="width: 200px;">
                    <option value="-1" <c:if test = "${status ==  -1}">selected </c:if>>Tình trạng heo</option>
                    <option value="1" <c:if test = "${status ==  1}">selected </c:if>>Bán</option>
                    <option value="0" <c:if test = "${status ==  0}">selected </c:if>>Chưa bán</option>
                </select>
            </label>

            <input type="text" name="pigId"
                   class="form-control form-control-sm"
                   placeholder="Tìm theo mã heo"
                   style="width: 200px;" value="${param.pigId}"/>

            <label>
                <select name="manufactureId" class="form-select form-select-sm" style="width: 200px;">
                    <option value="0">Xuất xứ</option>
                    <c:forEach var="manufacture" items="${manufactures}">
                        <option value="${manufacture.id}"
                                <c:if test="${param.manufactureId == manufacture.id}">selected</c:if>>
                                ${manufacture.name}
                        </option>
                    </c:forEach>
                </select>
            </label>

            <label>
                <select name="limit" class="form-select form-select-sm" style="width: 200px;">
                    <option value="0" <c:if test = "${limit ==  0}">selected </c:if>>Chọn top</option>
                    <option value="5" <c:if test = "${limit ==  5}">selected </c:if>>Chọn top 5</option>
                    <option value="10" <c:if test = "${limit ==  10}">selected </c:if>>Chọn top 10</option>
                </select>
            </label>

            <button type="submit" class="btn btn-warning btn-sm">Tìm kiếm</button>
        </form>
    </div>
</div>

<!-- Hiển thị thông báo lỗi căn giữa -->
<p class="text-center text-danger">${param.mess}</p>


<!-- Bảng sản phẩm -->
<div class="m-5">
    <table id="tableProduct" class="table table-hover table-bordered">
        <thead class="table-light">
        <tr style="background-color: #e3b159">
            <th scope="col">STT</th>
            <th scope="col">Mã số heo</th>
            <th scope="col">Ngày nhập chuồng</th>
            <th scope="col">Thời gian xuất chuồng</th>
            <th scope="col">Trọng lượng</th>
            <th scope="col">Trọng lượng khi xuất chuồng</th>
            <th scope="col">Xuất xứ</th>
            <th scope="col">Trạng thái</th>
            <th scope="col">Xóa</th>
            <th scope="col">Chỉnh sửa</th>
        </tr>
        </thead>
        <tbody style="background-color: #fff4e5">
        <c:if test="${empty pigs}">
            <td>không tìm thấy sản phẩm</td>
        </c:if>
        <c:forEach var="pig" items="${pigs}" varStatus="idx">
            <tr>
                <td>${idx.count}</td>
                <td>${pig.id}</td>
                <td>${pig.timeIn}</td>
                <td>${pig.timeOut}</td>
                <td>${pig.weightIn}</td>
                <td>${pig.weightOut}</td>
                <td>
                    <c:forEach var="manufacture" items="${manufactures}">
                        <c:if test="${manufacture.id==pig.manufactureId}">
                            ${manufacture.name}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <c:if test="${pig.status ==true}">
                    Bán
                    </c:if>
                    <c:if test="${pig.status !=true}">
                    Chưa bán
                    </c:if>
                <td>
                    <button onclick="deleteInfo('${pig.id}','${pig.id}')"
                            class="btn btn- btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        <i class="bi bi-trash text-danger me-2"></i></button>
                </td>
                <td>
                    <button
                            onclick="window.location.href='pig?action=update&id=${pig.id}'"
                            class="btn btn-warning btn-sm">
                        <i class="bi bi-pencil-square me-2"></i>
                    </button>
                </td>
            </tr>

        </c:forEach>


        </tbody>
    </table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="/pig?action=delete">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Xóa đồ uống</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input hidden="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn xoá heo có mã số </span> <span id="deleteName"></span> không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button class="btn btn-primary">Xoá</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    function deleteInfo(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }

</script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

</body>
</html>
