<?php

include 'components/connect.php';

session_start();

if(isset($_SESSION['user_id'])){
   $user_id = $_SESSION['user_id'];
}else{
   $user_id = '';
   header('location:home.php');
};

// Fetch user profile data
$fetch_profile = '';
$select_profile = $conn->prepare("SELECT * FROM `users` WHERE id = ?");
$select_profile->execute([$user_id]);
$fetch_profile = $select_profile->fetch(PDO::FETCH_ASSOC);

if(isset($_POST['submit'])){

   $name = $_POST['name'];
   $name = filter_var($name, FILTER_SANITIZE_STRING);
   $number = $_POST['number'];
   $number = filter_var($number, FILTER_SANITIZE_STRING);
   $email = $_POST['email'];
   $email = filter_var($email, FILTER_SANITIZE_STRING);
   $method = $_POST['method'];
   $method = filter_var($method, FILTER_SANITIZE_STRING);
   $address = $_POST['address'];
   $address = filter_var($address, FILTER_SANITIZE_STRING);
   $total_products = $_POST['total_products'];
   $total_price = $_POST['total_price'];

   $check_cart = $conn->prepare("SELECT * FROM `cart` WHERE user_id = ?");
   $check_cart->execute([$user_id]);

   if($check_cart->rowCount() > 0){

      if($address == ''){
         $message[] = 'please add your address!';
      }else{
         
         $insert_order = $conn->prepare("INSERT INTO `orders`(user_id, name, number, email, method, address, total_products, total_price) VALUES(?,?,?,?,?,?,?,?)");
         $insert_order->execute([$user_id, $name, $number, $email, $method, $address, $total_products, $total_price]);

         $delete_cart = $conn->prepare("DELETE FROM `cart` WHERE user_id = ?");
         $delete_cart->execute([$user_id]);

         $message[] = 'order placed successfully!';
         header('location:orders.php');
      }
      
   }else{
      $message[] = 'your cart is empty';
   }

}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>checkout</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style.css">

</head>
<body>
   
<!-- header section starts  -->
<?php include 'components/user_header.php'; ?>
<!-- header section ends -->

<?php if(isset($message)){
    foreach($message as $msg){
       echo '
       <div class="message">
          <span>'.$msg.'</span>
          <i class="fas fa-times" onclick="this.parentElement.remove();"></i>
       </div>
       ';
    }
} ?>

<div class="heading">
   <h3>checkout</h3>
   <p><a href="home.php">home</a> <span> / checkout</span></p>
</div>

<section class="checkout">

   <h1 class="title">order summary</h1>

<form action="" method="post">

   <div class="cart-items">
      <h3>cart items</h3>
      <?php
         $grand_total = 0;
         $cart_items[] = '';
         $select_cart = $conn->prepare("SELECT * FROM `cart` WHERE user_id = ?");
         $select_cart->execute([$user_id]);
         if($select_cart->rowCount() > 0){
            while($fetch_cart = $select_cart->fetch(PDO::FETCH_ASSOC)){
               $cart_items[] = $fetch_cart['name'].' ('.$fetch_cart['price'].' x '. $fetch_cart['quantity'].') - ';
               $total_products = implode($cart_items);
               $grand_total += ($fetch_cart['price'] * $fetch_cart['quantity']);
      ?>
      <p><span class="name"><?= $fetch_cart['name']; ?></span><span class="price">Rs.<?= $fetch_cart['price']; ?> x <?= $fetch_cart['quantity']; ?></span></p>
      <?php
            }
         }else{
            echo '<p class="empty">your cart is empty!</p>';
         }
      ?>
      <p class="grand-total"><span class="name">grand total :</span><span class="price">Rs.<?= $grand_total; ?></span></p>
      <a href="cart.php" class="btn">view cart</a>
   </div>

   <input type="hidden" name="total_products" value="<?= $total_products; ?>">
   <input type="hidden" name="total_price" value="<?= $grand_total; ?>">

   <div class="user-info">
      <h3>your info</h3>
      
      <!-- Name Field -->
      <p><i class="fas fa-user"></i><span><?= isset($fetch_profile['name']) ? $fetch_profile['name'] : 'Name not set'; ?></span></p>
      <input type="hidden" name="name" value="<?= isset($fetch_profile['name']) ? $fetch_profile['name'] : ''; ?>">

      <!-- Phone Field -->
      <p><i class="fas fa-phone"></i><span><?= isset($fetch_profile['number']) ? $fetch_profile['number'] : 'Phone not set'; ?></span></p>
      <input type="hidden" name="number" value="<?= isset($fetch_profile['number']) ? $fetch_profile['number'] : ''; ?>">

      <!-- Email Field -->
      <p><i class="fas fa-envelope"></i><span><?= isset($fetch_profile['email']) ? $fetch_profile['email'] : 'Email not set'; ?></span></p>
      <input type="hidden" name="email" value="<?= isset($fetch_profile['email']) ? $fetch_profile['email'] : ''; ?>">

      <a href="update_profile.php" class="btn">update info</a>

      <!-- Delivery Address Section -->
      <h3>delivery address</h3>
      
      <?php 
         if(isset($fetch_profile['address']) && $fetch_profile['address'] != ''){
            echo '<p><i class="fas fa-map-marker-alt"></i><span>'.$fetch_profile['address'].'</span></p>';
         }else{
            echo '<p><i class="fas fa-map-marker-alt"></i><span>please enter your address</span></p>';
         }
      ?>
      
      <a href="update_address.php" class="btn">update address</a>

      <!-- Hidden Address Field for Form -->
      <input type="hidden" name="address" value="<?= isset($fetch_profile['address']) ? $fetch_profile['address'] : ''; ?>">

      <!-- Payment Method Dropdown -->
      <select name="method" class="box" required>
         <option value="" disabled selected>select payment method --</option>
         <option value="cash on delivery">cash on delivery</option>
         <option value="credit card">credit card</option>
         <option value="debit card">debit card</option>
         <option value="paypal">paypal</option>
      </select>

      <!-- Place Order Button -->
      <input type="submit" value="place order" class="btn <?php if(!isset($fetch_profile['address']) || $fetch_profile['address'] == ''){echo 'disabled';} ?>" style="width:100%; background:var(--red); color:var(--white);" name="submit">
   </div>

</form>
   
</section>

<!-- footer section starts  -->
<?php include 'components/footer.php'; ?>
<!-- footer section ends -->

<!-- custom js file link  -->
<script src="js/script.js"></script>

</body>
</html>