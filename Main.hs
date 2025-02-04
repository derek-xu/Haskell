module Main where
import Vec
import Ray
import Sphere
import System.IO

-- Define image size
imageWidth, imageHeight :: Int
imageWidth = 400
imageHeight = 200

-- Define camera settings
lowerLeftCorner :: Vec
lowerLeftCorner = Vec (-2.0) (-1.0) (-1.0)

horizontal, vertical, cameraOrigin :: Vec
horizontal = Vec 4.0 0.0 0.0
vertical = Vec 0.0 2.0 0.0
cameraOrigin = Vec 0.0 0.0 0.0

-- Define the scene: a single sphere
sceneSphere :: Sphere
sceneSphere = Sphere (Vec 0 0 (-1)) 0.5

-- Compute color for a given ray
rayColor :: Ray -> Vec
rayColor r =
    case hitSphere sceneSphere r of
        Just t  -> let hitPoint = pointAt r t
                       normal = normalize (hitPoint ^-^ center sceneSphere)
                   in 0.5 *^ (normal ^+^ Vec 1 1 1)
        Nothing -> let unitDir = normalize (direction r)
                       t' = 0.5 * (yComponent unitDir + 1.0)
                   in (1 - t') *^ Vec 1 1 1 ^+^ t' *^ Vec 0.5 0.7 1.0
  where
    yComponent (Vec _ y _) = y

-- Convert a Vec color (0-1 range) to an RGB string (0-255)
writeColor :: Vec -> String
writeColor (Vec r g b) =
    let to255 x = floor (255.99 * max 0 (min 1 x))
    in show (to255 r) ++ " " ++ show (to255 g) ++ " " ++ show (to255 b)

-- Render the entire image
main :: IO ()
main = do
    putStrLn "P3"
    putStrLn $ show imageWidth ++ " " ++ show imageHeight
    putStrLn "255"

    mapM_ (renderRow imageWidth imageHeight) [imageHeight-1, imageHeight-2 .. 0]

renderRow :: Int -> Int -> Int -> IO ()
renderRow width height j = do
    let rowColors = [ pixelColor i j width height | i <- [0 .. width-1] ]
    putStrLn $ unwords rowColors

pixelColor :: Int -> Int -> Int -> Int -> String
pixelColor i j width height =
    let u = fromIntegral i / fromIntegral (width - 1)
        v = fromIntegral j / fromIntegral (height - 1)
        r = Ray cameraOrigin (normalize (lowerLeftCorner ^+^ (u *^ horizontal) ^+^ (v *^ vertical) ^-^ cameraOrigin))
    in writeColor (rayColor r)
