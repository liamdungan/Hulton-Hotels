
<!DOCTYPE html>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="Home.jsp">Home</a>
  <a href="MyReservations.jsp">Reservations</a>
  <a href="Reviews.jsp">Reviews</a>
  <a href="Statistics.jsp">Statistics</a>
  <hr>
  <a href="Logout.jsp">Logout</a>
</div>

<span style="font-size:30px;cursor:pointer;text-shadow: 1px 1px 1px #fff" onclick="openNav()">&#9776; <b>menu</b></span>

<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "160px";
    document.getElementById("main").style.marginLeft = "160px";
    container.style.backgroundColor = "rgba(255,255,255,0.6)";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
    container.style.backgroundColor = "white";
}
</script>