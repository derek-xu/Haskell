module Vec where

data Vec = Vec !Double !Double !Double deriving (Show, Eq)

-- Vector addition
(^+^) :: Vec -> Vec -> Vec
(Vec x1 y1 z1) ^+^ (Vec x2 y2 z2) = Vec (x1 + x2) (y1 + y2) (z1 + z2)

-- Vector subtraction
(^-^) :: Vec -> Vec -> Vec
(Vec x1 y1 z1) ^-^ (Vec x2 y2 z2) = Vec (x1 - x2) (y1 - y2) (z1 - z2)

-- Scalar multiplication
(*^) :: Double -> Vec -> Vec
s *^ (Vec x y z) = Vec (s*x) (s*y) (s*z)

-- Dot product
dot :: Vec -> Vec -> Double
dot (Vec x1 y1 z1) (Vec x2 y2 z2) = x1*x2 + y1*y2 + z1*z2

-- Vector magnitude (length)
len :: Vec -> Double
len v = sqrt (dot v v)

-- Normalize a vector
normalize :: Vec -> Vec
normalize v = (1 / len v) *^ v
