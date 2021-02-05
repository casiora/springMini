<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

 <style>
/* 선긋기
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
 */
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
 .hAddr {border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
 .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<title>지도</title>
<a href="/">홈 화면 바로가기</a>
<a href="../map/map">지도</a>
<a href="../board/list">게시판</a>

</head>
<body>
	
<div class="map_wrap">
	<!-- 지도 객체 -->
    <div id="map" style="width:80%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
			<div>
				<form onsubmit="searchPlaces(); return false;"> 
					키워드 : <input type="text" id="keyword"  />
					<button type="submit">검색</button>
				</form>
			 </div>
 		 </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
<div class="hAddr">
	<div class="title">지도중심기준 행정동 주소정보</div>
	<div id="centerAddr"></div>
</div>
<p>
	<!-- <button onclick="selectOverlay('MARKER')">마커</button> -->
	<button onclick="selectOverlay('POLYLINE')">선</button>
	<button onclick="selectOverlay('CIRCLE')">원</button>
	<button onclick="selectOverlay('RECTANGLE')">사각형</button>
	<button onclick="selectOverlay('POLYGON')">다각형</button>
</p>
<p class="edit" >
	<button id="undo" class="disabled" onclick="undo()" disabled>Undo</button>
	<button id="redo" class="disabled" onclick="redo()" disabled>Redo</button>
</p>

	<p id='result' />
	<!-- 확대/축소 버튼 
 	<button onclick="zoomIn()">지도 확대</button>
	<button onclick="zoomOut()">지도 축소</button> -->
	
	<!-- 드래그 이동 끄기/켜기 -->
	<p>
		<button onclick="setDraggabled(false)">지도 드래그 이동 끄기</button>	
		<button onclick="setDraggabled(true)">지도 드래그 이동 켜기</button>
	</p>
	<p>
		<button onclick="setDraggableMarker(false)">마커 드래그 이동 끄기</button>	
		<button onclick="setDraggableMarker(true)">마커 드래그 이동 켜기</button>	
	</p>
	<p>
		<button onclick="hideMarkers()">마커 감추기</button>	
		<button onclick="showMarkers()">마커 보이기</button>		
	</p>
	<!-- 스크롤만 막음
	<div>
		<button onclick="setZoomable(false)">지도 확대/축소 끄기</button>	
		<button onclick="setZoomable(true)">지도 확대/축소 켜기</button>
	</div> -->

	<!-- 카카오 지도 스크립트 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=eba57dfa46f3e890254e0754b5f3cce0&libraries=services,clusterer,drawing"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.51198, 127.11646),
			level: 2
		};

		var map = new kakao.maps.Map(container, options);
		
		var geocoder = new kakao.maps.services.Geocoder();
		
		//지도 타입변경 컨트롤러
		var mapTypeControl = new kakao.maps.MapTypeControl();		
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		
		//줌 컨트롤러
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		//교통정보 표시
		//map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
		
		//장소검색 객체 생성
		var ps = new kakao.maps.services.Places();
		
		//마커 생성
		var marker = new kakao.maps.Marker(),
			infowindow2 = new kakao.maps.InfoWindow({zIndex:1});
		
		var markers = [];
		
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		
 
		//윈포윈도우 설정
		var iwContent = '<div style="padding:5px; ">소명소프트</div>',
			iwPosition = new kakao.maps.LatLng(37.51198, 127.11646),
			iwRemoveable = true; //removeable 속성이 true면 x버튼 표시
		
		var smsinfowindow = new kakao.maps.InfoWindow({
			map: map,
			position : iwPosition,
			content : iwContent,
			removable : iwRemoveable
		});

		var drawingFlag = false; //선이 그려지고 있는 상태를 가지고 있을 변수
		var moveLine; //선이 그려지고 있을 때 마우스에 따라 그려질 선 객체
		var clickLine; //마우스로 클릭한 좌표로 그려질 선 객체
		var distanceOverlay; //선의 거리정보를 표시할 커스텀오버레이
		var dots= {}; //클릭할때 나오는 지점 배열
		
		var options = {
						map: map,
						drawingMode : [
							kakao.maps.drawing.OverlayType.MARKER,
							kakao.maps.drawing.OverlayType.POLYLINE,
							kakao.maps.drawing.OverlayType.RECTANGLE,
							kakao.maps.drawing.OverlayType.CIRCLE,
							kakao.maps.drawing.OverlayType.POLYGON							
						],
						
						guideTooltip: ['draw', 'drag', 'eidt'],
						markerOptions: {
							draggable : true,
							removable : true
						},
						polylineOptions : {
							draggable : true,
							removable : true,
							editable : true,
							strokeColor : '#39f',
							hintStrokeStyle : 'dash',
							hintStrokeOpacity : 0.5
						},
						rectangleOptions : {
							draggable : true,
							removable : true,
							editable : true,
							strokeColor : '#39f',
							fillColer : '#39f',
							fillOpacity : 0.5
						},
						circleOptions : {
							draggable : true,
							removable : true,
							editable : true,
							strokeColor : '#39f',
							fillColor : '#39f',
							fillOpacity : 0.5
						},
						polygonOptions : {
							draggable : true,
							removable : true,
							editable : true,
							strokerColor : '#39f',
							fillColor : '#39f',
							fillOpacity : 0.5,
							hintStrokeStyle : 'dash',
							hintStrokeOpacity : 0.5
						}
		
		};
		
		var manager = new kakao.maps.drawing.DrawingManager(options);
		
		// undo, redo 버튼의 disabled 속성을 설정하기 위해 엘리먼트를 변수에 설정합니다
		var undoBtn = document.getElementById('undo');
		var redoBtn = document.getElementById('redo');
		
		manager.addListener('state_changed', function(){
			
			if(manager.undoable()){
				undoBtn.disabled = false;
				undoBtn.className = "";
			} else {
				undoBtn.disabled = true;
				undoBtn.className = "disabled";				
			}
			
			if (manager.redoable()) {
				redoBtn.disabled = false;
				redoBtn.className = "";
			} else { // 아니면 redo 버튼을 비활성화 시킵니다 
				redoBtn.disabled = true;
				redoBtn.className = "disabled";
			}
		});
		
		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent){
			searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status){
				if(status === kakao.maps.services.Status.OK){
					var detailAddr = !!result[0].road_address ? '<div>도로명 주소 : ' + result[0].road_address.address_name + '</div>' : '';
						detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
						
					var content = '<div class="bAddr">' + '<span class="title">법정동 주소정보</span>' + detailAddr + '</div>';    
					
					marker.setPosition(mouseEvent.latLng);
					marker.setMap(map);
					
					infowindow2.setContent(content);
					infowindow2.open(map, marker);
				}
			});
		});
		
		//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function(){
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
						
		//마커를 맵에 표시
		//marker.setMap(map);
		
		//marker.setDraggable(true);
		
		//클릭한 위치 표시하기
		/* kakao.maps.event.addListener(map, 'click', function(mouseEvent){
			
			var clickPosition = mouseEvent.latLng;
			
			marker.setPosition(clickPosition);
						
			addMarker(clickPosition);
			
			 var message = '클릭한 위치의 위도는 ' + clickPosition.getLat() + ' 이고, ';
			message += '경도는 ' + clickPosition.getLng() + ' 입니다.';
			
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message; */
			
			/* 
			//지도 선 이벤트
			if(!drawingFlag){
				drawingFlag = true;
				deleteClickLine();
				deleteDistnce();
				deleteCircleDot();
				
				clickLine = new kakao.maps.Polyline({
					map: map,
					path: [clickPosition],	  //좌표 배열
					strokeWeight : 3, //선 두께
					strokeColor : '#db4040', //선 색깔
					strokeOpacity : 1, //선 불투명도
					strokeStyle : 'solid'
				});
				
				moveLine = new kakao.maps.Polyline({
					strokeWeight : 3, //선 두께
					strokeColor : '#db4040', //선 색깔
					strokeOpacity : 0.5, //선 불투명도
					strokeStyle : 'solid'
				});
				
				displayCircleDot(clickPosition, 0);
				
				
			} else { 
				//선이 그려지고 있는 상태
				var path = clickLine.getPath();
				
				path.push(clickPosition);
				
				clickLine.setPath(path);
				
				var distance = Math.round(clickLine.getLength());
				displayCircleDot(clickPosition, distance);
			} */
	//	});
		
	
		/*
		kakao.maps.event.addListener(map, 'mousemove', function(mouseEvent){
				
				var mousePosition = mouseEvent.latLng;
			
			if(drawing){
								
				var path = clickLine.getPath();
				
				var movepath = [path[path.length-1], mousePosition];
				moveLine.setPath(movepath);
				moveLine.setMap(map);
				
				var distance = Math.round(clickLine.getLength() + moveLine.getLength()),
					content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>';
					
					showDistance(content, mousePosition);
			}
		});
		
		kakao.maps.event.addListener(map, 'rightclick', function(mouseEvent){
			
			if(drawingFlag){
				
				moveLine.setMap(null);
				moveLine = null;
				
				var path = clickLine.getPath();
				
				if(path.length > 1){
					if(dots[dots.length-1].distance){
						dots[dots.length-1].distance.setMap(null);
						dots[dots.length-1].distance = null;
					}
					
					var distance = Math.round(clickLine.getLength()),
						content = getTimeHTML(distance);
					
					showDistance(content, path[path.length-1]);
				
				} else {
					
					deleteClickLine();
					deleteCircleDot();
					deleteDistnce();
				} 
				
				drawingFlag = false;
			}
		});
		
		function deleteClickLine(){
			if(clickLine){
				clickLine.setMap(null);
				clickLine = null;
			}
		}
		
		// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하고,
		// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다		
		function showDistance(content, position){
			
			if(distanceOverlay){
				
				distanceOverlay.setPosition(position);
				distanceOverlay.setContent(content);
			} else {
				
				distanceOverlay = new kakao.maps.CustomOverlay({
					map: map,
					content : content,
					position: position,
					xAnchor : 0,
					yAnchor : 0,
					zIndex : 3
				});
			}
		}
		
		function deleteDistnce(){
			if(distanceOverlay){
				distanceOverlay.setMap(null);
				distanceOverlay = null;
			}
		}
		
		function displayCircleDot(position, distance){
			
			var circleOverlay = new kakao.maps.CustomOverlay({
				content : '<span class="dot"></span>',
				position : position,
				zIndex: 1
			});
			
			circleOverlay.setMap(map);
			
			if(distance > 0){
				
				var distanceOverlay = new kakao.maps.CustomOverlay({
					content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
					position: position,
					yAnchor: 1,
					zIndex: 2
				});
				
				distanceOverlay.setMap(map);
			}
			
			  dots.push({circle:circleOverlay, distance: distanceOverlay});
		}
		
		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수
		function deleteCircleDot(){
			var i;
			
			for(i=0; i<dots.length; i++){
				if(dots[i].circle){
					dots[i].circle.setMap(null);
				}
				
				if(dots[i].distance){
					dots[i].distance.setMap(null);
				}
			}
			dots = [];
		}
		
		function getTimeHTML(distance){
			
			var walkTime = distance / 67 | 0;
			var walkHour = '', walkMin = '';
			
			if(walkTime > 60){
				walkHour = '<span class="number">' + Math.floor(walkTime/60) + '</span>시간'
			}
			walkMin = '<span class="number">' + walkTime % 60 + '</span>분'
			
			var content = '<ul class="dotOverlay distanceInfo">';
				content += '    <li>';
			    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
			    content += '    </li>';
			    content += '    <li>';
			    content += '        <span class="label">도보</span>' + walkHour + walkMin;
			    content += '    </li>';
			    content += '</ul>'
			    
			    return content;
		}  */
		
		
		
		function addMarker(position){
			//마커 생성
			var marker = new kakao.maps.Marker({
				position: position
				});
			
				marker.setMap(map);
			
				markers.push(marker);
						
		}
		
		function setMarkers(map){
			for(var i = 0; i<markers.length; i++){
				markers[i].setMap(map);
			}
		}
		
/* 		
		<!-- 지도 확대 : 레벨이 낮아지면 더 가까이서 보임 -->
		function zoomIn(){
			var level = map.getLevel();
			map.setLevel(level -1);
		}
		<!-- 지도 축소  : 레벨이 낮아지면 더 멀리서 보임-->
		function zoomOut(){
			var level = map.getLevel();
			map.setLevel(level +1);
		} */
		
		//지도 드래그
	 	function setDraggabled(draggable){			
			map.setDraggable(draggable);		
		} 
		
		//지도 확대/축소 on/off
		function setZoomable(zoomable){
			map.setZoomable(zoomable)
		}
		
	 	function setDraggableMarker(draggable){			
			marker.setDraggable(draggable);		
		} 
	 	
	 	//마커 보이기
	 	function showMarkers(){
	 		setMarkers(map)
	 	}

	 	//마커 감추기
	 	function hideMarkers(){
	 		setMarkers(null);
	 	}
		
	 	
	 	
	 	function searchPlaces(){
	 		
	 		var keyword = document.getElementById('keyword').value;
	 		
	 		if(!keyword.replace(/^\s+|\s+$/g, '')) {
	 			alert('키워드를 입력해주세요.');
	 			return false;
	 		}
	 		ps.keywordSearch( keyword, placesSearchCB); 
	 	}
	 	
	 	//장소검색이 완료됐을 때 호출되는 콜백함수
	 	function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}
	 	
	 	//검색 결과 목록 & 마커 표시
	 	function displayPlaces(places){
	 		
	 		var listEl = document.getElementById('placesList'),
	 			menuEl = document.getElementById('menu_wrap'),
	 			fragment = document.createDocumentFragment(),
	 			bounds = new kakao.maps.LatLngBounds(),
	 			listStr = '';
	 		
	 		//검색결과 목록 제거
	 		removeAllChildNods(listEl);
	 		//지도에 표시된 마커 제거
	 		removeMarker();
	 		
	 		for(var i=0; i<places.length; i++){
	 			
	 			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	 				marker = addMarker(placePosition, i),
	 				itemEl = getListItem(i, places[i]);
	 			
	 			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	 	        // LatLngBounds 객체에 좌표를 추가합니다	 			
	 			bounds.extend(placePosition);
	 			
	 			(function(marker, title){
 				    kakao.maps.event.addListener(marker, 'mouseover', function(){
 				    	displayInfowindow(marker, title);
	 				});
	 				
	 				kakao.maps.event.addListener(marker, 'mouseout', function(){
	 					infowindow.close();
	 				});
	 				
	 				itemEl.onmouseover = function(){
	 					displayInfowindow(marker, title);
	 				};
	 				
	 				itemEl.onmouseout = function(){
	 					infowindow.close();
	 				}
	 			})(marker, places[i].place_name);
	 			
	 			fragment.appendChild(itemEl);
	 			
	 		}
	 		//검색결과 홍목들을 검색결과 목록에 추가
			listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
	 		
	 		//검색된 장소 위치를 기준으로 범위 재설정
	 		map.setBounds(bounds);
	 	}
	 	
	 	//검색결과 항목을 element로 반환
	 	function getListItem(index, places){
	 		
	 		var el = document.createElement('li'),
	 			itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' + '<div class="info">' + '<h5>' + places.place_name + '</h5>';
	 			
 			if(places.road_address_name){
 				itemStr += '<span>' + places.road_address_name + '</span>' + '<span class="jibun gray">' + places.address_name + '</span>';
 			}else{
 				itemStr += '<span>' + places.address_name + '</span>';
 			}
 			
 			itemStr += '<span class="tel">' + places.phone + '</span>' + '</div>';
 			
 			el.innerHTML = itemStr;
 			el.className = 'item';
 			
 			return el;
 			
 			}
	 	
	 	function addMarker(position, idx, title){
	 		
	 		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
   				   });

		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
		    return marker;
	 	}
	 	
	 	function removeMarker(){
	 		for(var i=0; i<markers.length; i++){
	 			markers[i].setMap(null);
	 		}
	 		markers = [];
	 	}
	 	//검색결과 목록 하단 페이징 함수
	 	function displayPagination(pagination){
	 		var paginationEl = document.getElementById('pagination'),
	 			fragment = document.createDocumentFragment(),
	 			i;
	 		//기존에 추가된 페이지번호 삭제 함수
	 		while(paginationEl.hasChildNodes()){
	 			paginationEl.removeChild(paginationEl.lastChild);
	 		}
	 		
	 		for(i=1; i<=pagination.last; i++){
	 			var el = document.createElement('a');
	 			el.href = "#";
	 			el.innerHTML = i;
	 			
	 			if(i === pagination.current){
	 				el.className = 'on';
	 			} else {
	 				el.onclick = (function(i){
	 					return function(){
	 						pagination.gotoPage(i)
	 					}
	 				})(i);
	 			}
	 			fragment.appendChild(el);
	 		}
	 		paginationEl.appendChild(fragment);
	 	}
	 	
	 	function displayInfowindow(marker, title){
	 		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	 		
	 		infowindow.setContent(content);
	 		infowindow.open(map, marker);
	 	}
	 	
	 	function removeAllChildNods(el){
	 		  while (el.hasChildNodes()) {
	 			el.removeChild(el.lastChild);
	 		}
	 	}
	 	
	 	/* //검색 결과 마커 표시
	 	function displayMarker(place){
	 		
	 		var marker = new kakao.maps.Marker({
	 			map: map,
	 			position : new kakao.maps.LatLng(place.y, place.x)
	 		});
	 		
	 		kakao.maps.event.addListener(marker, 'click', function(){
	 			infowindow.setContent('<div style="padding:5px; font-size:12px;">' + place.place_name + '</div>');
	 			infowindow.open(map, marker);
	 		});
	 	} */
	 	
	 	//그리기 함수
		function selectOverlay(type){
			//그리기 중이면 그리기 취소
			manager.cancel();
			
			manager.select(kakao.maps.drawing.OverlayType[type]);
		}
	 	
	 	function undo(){
	 		manager.undo();
	 	}
	 	
	 	function redo(){
	 		manager.redo();
	 	}
	 	
	 	 // 좌표로 행정동 주소 정보를 요청합니다
	 	function searchAddrFromCoords(coords, callback){
	 		geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);   
	 	}
	 	
	 	  // 좌표로 법정동 상세 주소 정보를 요청합니다
	 	function searchDetailAddrFromCoords(coords, callback) {
	 	   geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	 	}
	 	  
	 // 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	 	function displayCenterInfo(result, status){
		 if(status === kakao.maps.services.Status.OK){
			 var infoDiv = document.getElementById('centerAddr');
			 
			 for(var i = 0; i <result.length; i++){   // 행정동의 region_type 값은 'H' 이므로
				 if(result[i].region_type === 'H'){
					 infoDiv.innerHTML = result[i].address_name;
					 break;
				 }
			 }
		 }
	 }
	</script>
</body>
</html>