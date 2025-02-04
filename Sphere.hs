module Sphere where
import Vec
import Ray

data Sphere = Sphere { center :: Vec, radius :: Double } deriving (Show)

-- Check if a ray intersects the sphere, returning the distance (t) if a hit occurs.
hitSphere :: Sphere -> Ray -> Maybe Double
hitSphere (Sphere c r) (Ray o d) =
    let oc = o ^-^ c
        a = dot d d
        b = 2.0 * dot oc d
        c' = dot oc oc - r * r
        discriminant = b * b - 4 * a * c'
    in if discriminant < 0 then Nothing
       else let sqrtDisc = sqrt discriminant
                t1 = (-b - sqrtDisc) / (2 * a)
                t2 = (-b + sqrtDisc) / (2 * a)
            in if t1 > 0 then Just t1
               else if t2 > 0 then Just t2
               else Nothing
