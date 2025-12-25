-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2025 at 07:29 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `password`) VALUES
(1, 'admin', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `pid`, `name`, `price`, `quantity`, `image`) VALUES
(5, 1, 2, 'Cheeseburger Deluxe', 120, 1, 'burger-2.png'),
(10, 2, 23, 'benne dosa', 143, 1, 'dish-1.png'),
(11, 2, 2, 'Cheeseburger Deluxe', 120, 1, 'burger-2.png');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `number` varchar(12) NOT NULL,
  `message` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `number` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL,
  `total_products` varchar(1000) NOT NULL,
  `total_price` int(100) NOT NULL,
  `placed_on` date NOT NULL DEFAULT current_timestamp(),
  `payment_status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `number`, `email`, `method`, `address`, `total_products`, `total_price`, `placed_on`, `payment_status`) VALUES
(1, 1, 'vishwarj', '7365352006', 'vishwarj736@gmail.com', 'cash on delivery', 'desainaagr, 7, railway colony, Bhavnagar, Bhavnagar, Gujarat, India - 364003', 'Burger Special (12 x 2) - Vegetarian Pizza (13 x 1) - ', 37, '2025-12-22', 'pending'),
(2, 1, 'vishwarj', '7365352006', 'vishwarj736@gmail.com', 'cash on delivery', 'desainaagr, 7, railway colony, Bhavnagar, Bhavnagar, Gujarat, India - 364003', 'Burger Special (12 x 1) - Vegetarian Pizza (13 x 1) - ', 25, '2025-12-23', 'pending'),
(3, 2, 'udayyyy', '9999888812', 'udayyyy@gmail.com', 'cash on delivery', 'house 19, 2, kunjgali, songadh, Bhavnagar, Gujarat, India - 364240', 'Spicy Pizza (169 x 2) - Margherita Pizza (150 x 3) - ', 788, '2025-12-23', 'pending'),
(4, 3, 'piyush', '8849603168', 'piyush@gmail.com', 'credit card', '1, 1, 1, 11, 1, 1, 1 - 364002', 'Cheeseburger Deluxe (120 x 1) - ', 120, '2025-12-23', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `price`, `image`) VALUES
(1, 'Burger Special', 'fast food', 90, 'burger-1.png'),
(2, 'Cheeseburger Deluxe', 'fast food', 120, 'burger-2.png'),
(3, 'Margherita Pizza', 'fast food', 150, 'pizza-1.png'),
(4, 'Pepperoni Pizza', 'fast food', 180, 'pizza-2.png'),
(5, 'Spicy Pizza', 'fast food', 169, 'pizza-3.png'),
(6, 'Vegetarian Pizza', 'fast food', 199, 'pizza-4.png'),
(7, 'Cheese Pizza', 'fast food', 160, 'pizza-5.png'),
(12, 'Fresh Orange Juice', 'drinks', 69, 'drink-1.png'),
(13, 'Cola Drink', 'drinks', 39, 'drink-2.png'),
(14, 'Mojito', 'drinks', 89, 'drink-3.png'),
(15, 'Lemonade', 'drinks', 29, 'drink-4.png'),
(16, 'Iced Tea', 'drinks', 90, 'drink-5.png'),
(17, 'Chocolate Cake', 'desserts', 220, 'dessert-1.png'),
(18, 'Ice Cream', 'desserts', 110, 'dessert-2.png'),
(19, 'Strawberry Cheesecake', 'desserts', 250, 'dessert-3.png'),
(20, 'Chocolate Brownies', 'desserts', 120, 'dessert-4.png'),
(21, 'Vanilla Cupcakes', 'desserts', 69, 'dessert-5.png'),
(22, 'Fruit Pudding', 'desserts', 89, 'dessert-6.png'),
(23, 'south Indian dish', 'Main Dish', 143, 'dish-1.png'),
(24, 'chinese dish', 'Main Dish', 190, 'dish-3.png'),
(25, 'gujarati thali', 'Main Dish', 90, 'dish-4.png'),
(26, 'Rajasthani dish', 'Main Dish', 220, 'dish-5.png'),
(27, 'punjabi dish', 'Main Dish', 199, 'dish-6.png'),
(28, 'mexican dish', 'Main Dish', 239, 'dish-7.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` varchar(10) NOT NULL,
  `password` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `number`, `password`, `address`) VALUES
(1, 'vishwarj', 'vishwarj736@gmail.com', '7365352006', '75296333403569250a6a234f6e5ab8e4dadb56c8', 'desainaagr, 7, railway colony, Bhavnagar, Bhavnagar, Gujarat, India - 364003'),
(2, 'udayyyy', 'udayyyy@gmail.com', '9999888812', '61526fdea1f75b8173c9557bc66ad1161451450a', 'house 19, 2, kunjgali, songadh, Bhavnagar, Gujarat, India - 364240'),
(3, 'piyush', 'piyush@gmail.com', '8849603168', '065356cea7b8314ffac528886736b1dc4bdf9a34', '1, 1, 1, 11, 1, 1, 1 - 364002');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
