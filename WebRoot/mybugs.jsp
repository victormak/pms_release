<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="bootstrap/docs/favicon.ico">
<title>我的任务</title>
<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="bootstrap/docs/assets/js/ie-emulation-modes-warning.js"></script>
<link href="bootstrap/docs/examples/carousel/carousel.css"
	rel="stylesheet">
<script src="bootstrap/js/tests/vendor/jquery.min.js"></script>
<script src="bootstrap/dist/js/bootstrap.min.js"></script>
<script src="bootstrap/docs/assets/js/docs.min.js"></script>
<script src="bootstrap/docs/assets/js/ie10-viewport-bug-workaround.js"></script>

<!-- datatimepicker -->
<link
	href="bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen"></link>
<script type="text/javascript"
	src="bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.fr.js"
	charset="UTF-8"></script>
<!-- datatimepicker -->

<script type="text/javascript">
     	$(document).ready(function(){
     		var sigin_user_id = "<%=session.getAttribute("sigin_user_id")%>";
     		$.ajax({
     			url:'getAllMyTask.action',
     			data:{id:sigin_user_id},
     			dataType:'json',
	    		success: function(data){
	    			//获取menu菜单栏各个任务的任务个数
	    			var t_object = eval(data);
	    			var t_number = t_object["data"].length;
	    			//获取我的任务具体内容
	    			var mytask_start_time = t_object["data"][0].task_start_time;
	    			//console.log(data);
		    		var wel_panel = document.getElementById("wel_panel");
		    		var arr = new Array();
		    		var uname = "<%=session.getAttribute("username")%>";
		    		
					//var executionids = t_object["data"][i].task_execution_ids;
					var execution_names = "";
					$.ajax({
						url : '',//getUsersByIds.action
						dataType : 'json',
						data : {
							ids : 101
						},
						success : function(data) {
							execution_names = data;
						}
					});
					for ( var i = 0; i < t_number; i++) { //循环创造出所有任务列表
						//初始化 任务列表 右侧
						arr[i] = "<div class=\"col-md-4 \"><div class=\"list-group\"><a data-toggle=\"modal\" data-target=\"#myModal\" class=\"list-group-item active\"><h4 class=\"list-group-item-heading\"><span class=\"glyphicon glyphicon-star-empty\"></span>"
								+ t_object["data"][i].task_title
								+ "</h4></a><a data-toggle=\"modal\" data-target=\"#myModal\" class=\"list-group-item\"><h4 class=\"list-group-item-heading\">开始时间："
								+ mytask_start_time
								+ "</h4><p class=\"list-group-item-text\"><h4 class=\"list-group-item-heading\">计划结束时间："
								+ t_object["data"][i].task_end_time
								+ "</h4></p></a><a href=\"#\" class=\"list-group-item\"><h4 class=\"list-group-item-heading\">创建人："
								+ uname
								+ "</h4><p class=\"list-group-item-text\"><h4 class=\"list-group-item-heading\">执行人："
								+ t_object["data"][i].task_execution_ids
								+ "</h4> </p></a> <a  class=\"list-group-item\"><button type=\"button\" class=\"btn btn-default\" onclick=\"changetype("
								+ i
								+ ")\"><span id=\"opticon"+i+"\" class=\"glyphicon glyphicon-minus\"></span></button><button type=\"button\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-trash\"></span></button></a></div></div>";
					}
					var str = arr.join("");
					wel_panel.innerHTML = str;
					//获取我的任务的各项分类数字
					var myexectionids = t_object["mytaskInfo"][0].my_exection_task_ids;
					var my_track_task_ids = t_object["mytaskInfo"][0].my_track_task_ids;
					var my_finish_task_ids = t_object["mytaskInfo"][0].my_finish_task_ids;
					var my_star_task_ids = t_object["mytaskInfo"][0].my_star_task_ids;
					var my_overdue_task_ids = t_object["mytaskInfo"][0].my_overdue_task_ids;
					var my_alreadydue_task_ids = t_object["mytaskInfo"][0].my_alreadydue_task_ids;
					var exection_number = myexectionids.split(",");
					var track_number = my_track_task_ids.split(",");
					var finish_number = my_finish_task_ids.split(",");
					var star_number = my_star_task_ids.split(",");
					var overdue_number = my_overdue_task_ids.split(",");
					var alreadydu_number = my_alreadydue_task_ids.split(",");
					console.log(exection_number.length);
					//获取 menu我的任务 span id
					var mytask_totalnumber = document.getElementById("mytask_total");
					var my_execution_task = document.getElementById("my_execution_task");
					var my_track_task = document.getElementById("my_track_task");
					var my_finish_task = document.getElementById("my_finish_task");
					var my_star_task = document.getElementById("my_star_task");
					var my_overdue_task = document.getElementById("my_overdue_task");
					var my_already_task = document.getElementById("my_already_task");

					if (t_number > 0) {
						mytask_totalnumber.innerHTML = t_number;
						my_execution_task.innerHTML = exection_number.length;
						my_track_task.innerHTML = track_number.length;
						my_finish_task.innerHTML = finish_number.length;
						my_star_task.innerHTML = star_number.length;
						my_overdue_task.innerHTML = overdue_number.length;
						my_already_task.innerHTML = alreadydu_number.length;
					} else {
						mytask_totalnumber.innerHTML = "";
					}
				},
				error : function() {
					console.log("error");
				}
			});
		});
	function getMyAllocateion() {
		$.ajax({
			url : 'getAllMyTask.action',
			dataType : 'json',
			data : {
				id : 2
			},
			type : 'post',
			success : function(data) {
				alert(data);
			}
		});
	}
	function signout() {
		$.ajax({
			url : 'signout.action',
			type : 'post',
			success : function() {
				//清空缓存
				//回到首页
			}
		});
	}
	//更改任务完成状态
	function changetype(index) {
		var idtemp = "opticon" + index + "";
		console.log("-------" + idtemp);
		var currenttype = document.getElementById(idtemp).getAttribute("class");
		console.log(currenttype);
		var oktype = "glyphicon glyphicon-ok";
		if (currenttype == oktype) {
			document.getElementById(idtemp).setAttribute("class",
					"glyphicon glyphicon-minus");
			//更改数据库状态 ajax
		} else {
			document.getElementById(idtemp).setAttribute("class",
					"glyphicon glyphicon-ok");
			//更改数据库状态 ajax
		}
	}
	//选择所有用户
	function selectall(execution_username){
		console.log("checkbox");
//		 $('[name='+execution_username+']:checkbox').attr("checked", true);
		 $('[name='+execution_username+']:checkbox').prop("checked",true);
		
	}
	//uncheck所有用户
	function unselectall(){
		$('[type=checkbox]:checkbox').prop('checked', false);
	}
	//添加任务提交form
	function addtask(){
		var a = document.getElementById("endtimeid").value;
		var b = document.getElementById("starttimeid").value;
		
		console.log(a+":"+b);
		//document.getElementById("").submit();
	}
	$(document).ready(function() {
		$('#datetimepicker1').datetimepicker({
			language : 'ru'
		});
		$('#datetimepicker2').datetimepicker({
			language : 'ru'
		});
		// back to top 
            var scrollDiv = document.createElement('div');
            $(scrollDiv).attr('id', 'toTop').html('^ 返回顶部').appendTo('body');
            $(window).scroll(function() {
                if ($(this).scrollTop() != 0) {
                    $('#toTop').fadeIn();
                } else {
                    $('#toTop').fadeOut();
                }
            });
            $('#toTop').click(function() {
                $('body,html').animate({ scrollTop: 0 }, 800);
            });
         // back to top 
	});
</script>
<style type="text/css">
        #toTop
{
            width: 100px;
            z-index: 10;
            border: 1px solid #333;
            background: #121212;
            text-align: center;
            padding: 5px;
            position: fixed;
            bottom: 0px;
            right: 0px;
            cursor: pointer;
            display: none;
            color: #fff;
            text-transform: lowercase;
            font-size: 0.9em;
}
    </style>
</head>

<body>
	<!--导航栏-->
	<nav class="navbar navbar-default" role="navigation">
	<div class="navbar-header">
		<a class="navbar-brand" href="#">FireBugs</a>
	</div>
	<div>
		<form class="navbar-form navbar-left" role="search">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Search">
			</div>
			<button type="submit" class="btn btn-default">提交按钮</button>
		</form>
	</div>
	<!-- 导航栏右侧 -->
	<div>
		<div class="btn-group" style="padding-top:8px;">
			<button type="button" class="btn btn-default " data-toggle="modal"
				data-target="#addtaskModal">
				<span class="glyphicon glyphicon-plus"></span>添加任务
			</button>
			<button type="button" class="btn btn-default" data-toggle="modal"
				data-target="#sendtaskModal">
				<span class="glyphicon glyphicon-envelope"></span>发送周报
			</button>
		</div>
		<p class="navbar-text navbar-right">
			<a href="mailto:sun-guangning@126.com"> 意见反馈 </a>
		</p>
		<div class="btn-group navbar-right"
			style="padding-top:10px;padding-left:10px;">
			<button class="btn btn-default " data-toggle="modal"
				data-target="#addressModal">通讯录</button>
		</div>

		<div class="btn-group navbar-right" style="padding-top:10px;">
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown">
				<%=session.getAttribute("username")%><span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">功能</a>
				</li>
				<li><a href="#">另一个功能</a>
				</li>
				<li><a href="#">其他</a>
				</li>
				<li class="divider"></li>
				<li><a onclick="signout()">退出</a>
				</li>
			</ul>
		</div>
	</div><!-- 导航栏右侧 --><!--导航栏--><!--end row  -->
	 <!-- 发送周报 模态框 -->
	<div class="modal fade" id="sendtaskModal" tabindex="-1" role="dialog"
		aria-labelledby="sendtaskModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="sendtaskModalLabel">发送周报</h4>
				</div>
				<div class="modal-body">在这里添加一些文本</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">发布动态</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div><!-- 发送周报 模态框 --> 
	<!-- 添加任务 模态框 -->
	<div class="modal fade" id="addtaskModal" tabindex="-1" role="dialog"
		aria-labelledby="addtaskModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="addtaskModalLabel">添加任务</h4>
				</div>
				<div class="modal-body">
					<div style="padding: 30px 50px 10px;">
						<form id="addtaskform" class="bs-example bs-example-form"role="form">
							<div class="input-group">
								<span class="input-group-addon"> 任务名称</span> <input type="text"
									class="form-control" placeholder="请输入任务名称.....">
							</div>
							<br>

							<div class="input-group">
								<span class="input-group-addon"> 任务内容</span> <input type="text"
									class="form-control" placeholder="请输入任务内容.....">
							</div>
							<br>
							<div class='input-group date' id='datetimepicker1'>
								<span class="input-group-addon">开始时间</span> 
									<input type='text' id="starttimeid"
									class="form-control" placeholder="请选择开始时间..... " /> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-calendar"></span> </span>
							</div>
							<br>
							<div class='input-group date' id='datetimepicker2'>
								<span class="input-group-addon">结束时间</span> 
									<input type='text' id="endtimeid"
									class="form-control" placeholder="请选择结束时间..... " /> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-calendar"></span> </span>
							</div>
							<br>
							<div class="input-group">
								<div id="myCollapsibleExample">
									<a href="#select_execution_users" style="padding-right: 10px" data-toggle="collapse">
										<span class="glyphicon glyphicon-user"></span>选择执行人员 
									</a>
									<button type="button" class="btn btn-default"  onclick="selectall('execution_name')">
										<span class="glyphicon glyphicon-check"></span>
									</button>
									<button type="button" class="btn btn-default"  onclick="unselectall()">
										<span class="glyphicon glyphicon glyphicon-unchecked"></span>
									</button>
								</div>
								<div id="select_execution_users" class="collapse">
									<div class="checkbox">
									      <label>
									      <input type="checkbox" name="execution_name"> jangwooning
									      </label>
									      <label>
									      <input type="checkbox" name="execution_name"> admin
									      </label>
									</div> 
								</div>
							</div>
							<br>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" onclick="addtask()">发布动态</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div><!-- 添加任务 模态框 -->
	 <!-- 通讯录 模态框 -->
	<div class="modal fade" id="addressModal" tabindex="-1" role="dialog"
		aria-labelledby="addressModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="addressModalLabel">通讯录</h4>
				</div>
				<div class="modal-body">
					<ul class="list-group">
					   <li class="list-group-item" onclick="selectexeuser()"> <input type="checkbox" name="address_name"> jangwooning@126.com</li>
					   <li class="list-group-item">免费 Window 空间托管</li>
					   <li class="list-group-item">图像的数量</li>
					</ul>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">发布动态</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div><!-- 通讯录 模态框 --> 
	<!-- 任务详细信息 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">任务标题</h4>
				</div>
				<div class="modal-body">在这里添加一些文本</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">发布动态</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	</nav><!--导航栏-->
	
	<!-- 正文主页部分 -->
	<div class="container">
		<div class="row row-offcanvas row-offcanvas-left">
			<div class=" col-md-2  sidebar" id="sidebar" role="navigation">
				<div class=" span3 list-group">
					<a href="#" class="list-group-item active">我的任务<span
						class="badge" id="mytask_total"></span>
					</a> <a href="#" class="list-group-item">我分配的任务<span class="badge"
						id="my_execution_task"></span>
					</a> <a href="#" class="list-group-item">我关注的任务<span class="badge"
						id="my_track_task"></span>
					</a> <a href="#" class="list-group-item">已完成的任务<span class="badge"
						id="my_finish_task"></span>
					</a> <a href="#" class="list-group-item">标星任务<span class="badge"
						id="my_star_task"></span>
					</a> <a href="#" class="list-group-item">即将过期任务<span class="badge"
						id="my_overdue_task"></span>
					</a> <a href="#" class="list-group-item">已过期任务<span class="badge"
						id="my_already_task"></span>
					</a>
				</div>
			</div>
			<!--/span-->
			<!--任务列表  -->
			<div class="col-md-10 row" id="wel_panel"></div>
			<!--任务列表  -->
		</div>
		<!-- end row -->
	</div>
	<!-- end container -->
	<div class="blog-footer">
		<p>
			<a href="mybugs.jsp">Back to top</a>
		</p>
	</div>
</body>
</html>
