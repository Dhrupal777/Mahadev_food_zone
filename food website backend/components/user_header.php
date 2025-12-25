<?php 

if(isset($message)){
    foreach($message as $message){
       echo '
       <div class="message">
          <span>'.$message.'</span>
          <i class="fas fa-times" onclick="this.parentElement.remove();"></i>
       </div>
       ';
    } 
} 

// Fetch user profile if user is logged in
$fetch_profile = '';
if($user_id != ''){
   $select_profile = $conn->prepare("SELECT * FROM `users` WHERE id = ?");
   $select_profile->execute([$user_id]);
   $fetch_profile = $select_profile->fetch(PDO::FETCH_ASSOC);
}

?>

<header class="header">
    <section class="flex">
       <a href="home.php" class="logo"> <b>Mahadev Food Zone</b></a>
       <nav class="navbar">
          <a href="home.php">Home</a>
          <a href="about.php">About</a>
          <a href="menu.php">Menu</a>
          <a href="orders.php">Orders</a>
          <a href="contact.php">Contact</a>
       </nav>

       <div class="icons">
          <?php 
             if($user_id != ''){
                $count_cart_items = $conn->prepare("SELECT * FROM `cart` WHERE user_id = ?");
                $count_cart_items->execute([$user_id]);
                $total_cart_items = $count_cart_items->rowCount();
             }else{
                $total_cart_items = 0;
             }
          ?>
          <a href="search.php"><i class="fas fa-search"></i></a>
          <a href="cart.php"><i class="fas fa-shopping-cart"></i><span>(<?= $total_cart_items; ?>)</span></a>
          <div id="user-btn" class="fas fa-user"></div>
          <div id="menu-btn" class="fas fa-bars"></div>
       </div>

       <div class="profile">
          <?php 
             if($user_id != '' && $fetch_profile){
          ?>
          <p class="name"><?= $fetch_profile['name']; ?></p>
          <div class="flex">
             <a href="profile.php" class="btn">profile</a>
             <a href="components/user_logout.php" onclick="return confirm('logout from this website?');" class="delete-btn">logout</a>
          </div>
          <?php 
             }else{
          ?>
          <p class="account">
             <a href="login.php">login</a> or 
             <a href="register.php">register</a>
          </p>
          <?php 
             }
          ?>
       </div>
    </section>
</header>