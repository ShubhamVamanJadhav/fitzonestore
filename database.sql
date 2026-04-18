-- phpMyAdmin SQL Dump
-- version 5.2.0
-- Host: 127.0.0.1
-- Generation Time: Apr 14, 2026
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `fitzone` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `fitzone`;

-- --------------------------------------------------------

-- Table structure for `products`
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `image` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `rating` float DEFAULT 4.5,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for `products`
INSERT INTO `products` (`id`, `name`, `price`, `category`, `image`, `description`, `rating`) VALUES
(1, 'Whey Protein Isolate 5lbs', 4999.00, 'Protein', 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?auto=format&fit=crop&w=900&q=80', 'Fast-absorbing whey isolate for lean muscle recovery.', 4.8),
(2, 'Adjustable Dumbbells 50lbs', 18999.00, 'Dumbbells', 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=900&q=80', 'Space-saving adjustable dumbbells for progressive strength training.', 4.9),
(3, 'Treadmill Pro X', 74999.00, 'Gym Equipment', 'https://images.unsplash.com/photo-1434596922112-19c563067271?auto=format&fit=crop&w=900&q=80', 'High-performance treadmill with incline and smart workout presets.', 4.7),
(4, 'Leather Lifting Belt', 2499.00, 'Accessories', 'https://images.unsplash.com/photo-1620188467120-5042ed1eb5da?auto=format&fit=crop&w=900&q=80', 'Heavy-duty lifting belt for core stability and safer compound lifts.', 4.7),
(5, 'Creatine Monohydrate', 1899.00, 'Protein', 'https://images.unsplash.com/photo-1593095948071-474c5cc2989d?auto=format&fit=crop&w=900&q=80', 'Micronized creatine for strength, power, and performance support.', 4.6),
(6, 'Hex Dumbbell Pair 20kg', 9999.00, 'Dumbbells', 'https://images.unsplash.com/photo-1638536532686-d610adfc8e5c?auto=format&fit=crop&w=900&q=80', 'Rubber-coated hex dumbbells with anti-roll design for home gyms.', 4.8),
(7, 'Olympic Barbell 20kg', 15999.00, 'Gym Equipment', 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=900&q=80', 'Knurled Olympic barbell with smooth sleeve rotation.', 4.7),
(8, 'Bumper Plate Set 100kg', 42999.00, 'Gym Equipment', 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=900&q=80', 'Durable bumper plates for deadlifts, cleans, and cross training.', 4.8),
(9, 'Kettlebell 24kg', 6299.00, 'Dumbbells', 'https://source.unsplash.com/900x900/?kettlebell,fitness', 'Solid-cast kettlebell for swings, squats, and full-body workouts.', 4.7),
(10, 'Weight Bench Adjustable', 12999.00, 'Gym Equipment', 'https://source.unsplash.com/900x900/?weight-bench,workout', 'Flat/incline/decline weight bench with heavy-duty steel frame.', 4.6),
(11, 'Resistance Band Set', 1499.00, 'Accessories', 'https://source.unsplash.com/900x900/?resistance-bands,fitness', 'Five-level resistance bands for warm-ups and mobility training.', 4.5),
(12, 'Gym Gloves Pro', 999.00, 'Accessories', 'https://source.unsplash.com/900x900/?gym-gloves,workout', 'Breathable palm-padded gloves for better grip and comfort.', 4.4),
(13, 'Skipping Rope Speed', 799.00, 'Accessories', 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=900&q=80', 'Adjustable steel cable rope for HIIT and endurance sessions.', 4.4),
(14, 'Yoga Mat Non-Slip', 1399.00, 'Accessories', 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?auto=format&fit=crop&w=900&q=80', 'Extra-thick non-slip mat for stretching, yoga, and floor exercises.', 4.8),
(15, 'Shaker Bottle 700ml', 499.00, 'Accessories', 'https://source.unsplash.com/900x900/?shaker-bottle,gym', 'Leak-proof shaker with blender ball for smooth supplement mixes.', 4.3),
(16, 'Mass Gainer 3kg', 3499.00, 'Protein', 'https://source.unsplash.com/900x900/?protein-powder,fitness', 'Calorie-dense gainer blend to support healthy bulking goals.', 4.5),
(17, 'Pre-Workout Nitro Blast', 2199.00, 'Protein', 'https://images.unsplash.com/photo-1612532275214-e4ca76d0e4d1?auto=format&fit=crop&w=900&q=80', 'High-energy pre-workout with caffeine and performance boosters.', 4.4),
(18, 'BCAA Recovery Formula', 1699.00, 'Protein', 'https://source.unsplash.com/900x900/?bcaa,supplements', 'Branched-chain amino acids to reduce fatigue and muscle soreness.', 4.3),
(19, 'Foam Roller Deep Tissue', 1199.00, 'Accessories', 'https://images.unsplash.com/photo-1599058917765-a780eda07a3e?auto=format&fit=crop&w=900&q=80', 'High-density roller for post-workout mobility and recovery.', 4.5),
(20, 'Pull-Up Bar Doorway', 2199.00, 'Gym Equipment', 'https://source.unsplash.com/900x900/?pull-up-bar,home-gym', 'Secure doorway pull-up bar for upper-body bodyweight training.', 4.4),
(21, 'Ankle Weights 5kg Pair', 1799.00, 'Accessories', 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=900&q=80', 'Adjustable ankle/wrist weights for added resistance.', 4.2),
(22, 'Ab Roller Wheel', 899.00, 'Accessories', 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&w=900&q=80', 'Dual-wheel ab roller with ergonomic grip for core workouts.', 4.3),
(23, 'Flat Bench Press Rack', 16999.00, 'Gym Equipment', 'https://images.unsplash.com/photo-1517344884509-a0c97ec11bcc?auto=format&fit=crop&w=900&q=80', 'Compact bench press rack with stable, reinforced frame.', 4.6),
(24, 'Protein Bars Pack of 12', 1299.00, 'Protein', 'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?auto=format&fit=crop&w=900&q=80', 'High-protein snack bars for on-the-go nutrition support.', 4.2);

-- --------------------------------------------------------

-- Table structure for `users`
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for `orders`
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('Pending','Completed','Failed') DEFAULT 'Pending',
  `created_at` timestamp DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for `payment_transactions`
CREATE TABLE `payment_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `razorpay_order_id` varchar(100) NOT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  `razorpay_signature` varchar(255) DEFAULT NULL,
  `status` enum('created','paid','failed') DEFAULT 'created',
  `created_at` timestamp DEFAULT current_timestamp(),
  `updated_at` timestamp DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_razorpay_order_id` (`razorpay_order_id`),
  KEY `idx_local_order_id` (`local_order_id`),
  CONSTRAINT `fk_payment_local_order` FOREIGN KEY (`local_order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_payment_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for `subscribers`
CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL UNIQUE,
  `subscribed_at` timestamp DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
