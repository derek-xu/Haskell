module Ray where
import Vec

data Ray = Ray { origin :: Vec, direction :: Vec } deriving (Show)

-- Compute a point along a ray at parameter t
pointAt :: Ray -> Double -> Vec
pointAt (Ray o d) t = o ^+^ (t *^ d)
