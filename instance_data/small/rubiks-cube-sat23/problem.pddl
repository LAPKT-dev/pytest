;; Generated with ./generator.py 10
(define
(problem rubiks-cube-shuffle-10)
(:domain rubiks-cube)
(:objects yellow white blue green orange red)
(:init
    (cube1 white red green)
    (cube2 yellow blue red)
    (cube3 red green yellow)
    (cube4 white green orange)
    (cube5 blue white red)
    (cube6 yellow orange green)
    (cube7 yellow blue orange)
    (cube8 white blue orange)
    (edge12 red white)
    (edge24 orange yellow)
    (edge34 yellow blue)
    (edge13 red yellow)
    (edge15 white blue)
    (edge26 green white)
    (edge48 orange green)
    (edge37 red green)
    (edge56 red blue)
    (edge68 yellow green)
    (edge78 blue orange)
    (edge57 orange white)
)
(:goal
    (and
        (cube1 red white blue)
        (cube2 orange white blue)
        (cube3 red yellow blue)
        (cube4 orange yellow blue)
        (cube5 red white green)
        (cube6 orange white green)
        (cube7 red yellow green)
        (cube8 orange yellow green)

        (edge12 white blue)
        (edge24 orange blue)
        (edge34 yellow blue)
        (edge13 red blue)

        (edge15 red white)
        (edge26 orange white)
        (edge48 orange yellow)
        (edge37 red yellow)

        (edge56 white green)
        (edge68 orange green)
        (edge78 yellow green)
        (edge57 red green)

    )
)
)
