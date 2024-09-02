<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8" />
        <title>사장페이지</title>

        <script type="text/javascript">
            function del(owner_id) {
                //console.log(mem_idx,"삭제");
                if (confirm("정말 탈퇴 하시겠습니까?") == false) return;

                //삭제요청
                location.href = "ownerpage/delete.do?owner_id=" + owner_id;
            }
        </script>
    </head>

    <body>
        <input type="hidden" name="owner_id" value="${owner.owner_id}" />
        <h1>사&nbsp;장&nbsp;정&nbsp;보</h1>
        <div class="container mx-auto p-6">
            <div class="mb-4">
                <lable for="name">이름:</lable>
                <input class="form-control" type="text" value="${owner.owner_name}" readonly />
            </div>
            <div class="mb-4">
                <lable for="accountId">아이디:</lable>
                <input class="form-control" type="text" value="${owner.owner_accountId}" readonly />
            </div>
            <div class="mb-4">
                <lable for="password">비밀번호:</lable>
                <input class="form-control" type="password" value="${owner.owner_pwd}" readonly />
            </div>
            <div class="mb-4">
                <lable for="email">이메일:</lable>
                <input class="form-control" type="text" value="${owner.owner_email}" readonly />
            </div>
                <div class="mb-4">
                    <lable for="phone">전화번호:</lable>
                    <input class="form-control" type="text" value="${owner.owner_phone}" readonly />
                </div>
                <div class="mb-4">
                    <lable for="license">사업자등록번호:</lable>
                    <input class="form-control" type="text" value="${owner.owner_license}" readonly />
                </div>
                <div class="mb-4">
                    <lable for="bankbook">법인통장번호:</lable>
                    <input class="form-control" type="text" value="${owner.owner_bankbook}" readonly />
                </div>
                <div class="flex justify-end">
                    <c:if test="( owner_user.owner_id eq owner.owner_id )">
                        <input type="button" value="회원 수정"
                            onclick="location.href='ownerpage/modify_form.do?owner_id=${owner.owner_id}'" />
                        <input type="button" value="회원 탈퇴" onclick="del('${ owner.owner_id }');" />
                    </c:if>
                </div>
            </div>
        </div>
    </body>

    </html>