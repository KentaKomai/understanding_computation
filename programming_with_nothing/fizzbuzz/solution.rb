require './helper'

# Number
ZERO    = -> p { -> x {       x    } }
ONE     = -> p { -> x {     p[x]   } }
TWO     = -> p { -> x {   p[p[x]]  } }
THREE   = -> p { -> x { p[p[p[x]]] } }
FIVE    = -> p { -> x { p[p[p[p[p[x]]]]] } }
FIFTEEN = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HUNDRED = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

# Boolean
TRUE  = -> x { -> y {x}}
FALSE = -> x { -> y {y}}
IF = -> b { b }

p IF[TRUE]['happy']['sad']
p IF[FALSE]['happy']['sad']


IS_ZERO = -> n { n[ -> x {FALSE}][TRUE] }

PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }


INCREMENT = -> n { -> p { -> x { p[n[p][x]] } } }
SLIDE     = -> p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = -> n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

p to_integer(DECREMENT[HUNDRED])

ADD      = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY = -> m { -> n { n[ADD[m]][ZERO] } }
POWER    = -> m { -> n { n[MULTIPLY[m]][ONE] } }

IS_LESS_OR_EQUAL = -> m { -> n { IS_ZERO[SUBTRACT[m][n]] } }
MOD = -> m { -> n {
  IF[IS_LESS_OR_EQUAL[n][m]][ -> x {
    MOD[SUBTRACT[m][n]][n][x]
  }]
}}

MOD = -> m { -> n {
  IF[IS_LESS_OR_EQUAL[n][m]][ -> x {
      MOD[SUBTRACT[m][n]][n][x]
    }
  ][m]
}}


p to_integer(MOD[THREE][TWO])

# Y Combinator
# 引数のprocを"proc自体を第一引数"として呼び出す。
Y_COMBINATOR = -> f {
  -> x { f[ x[x] ] }[ -> x { f[ x[x] ] } ]
}
Z_COMBINATOR = -> f {
  -> x { f[-> y { x[x][y] }] }[-> x { f[-> y { x[x][y] }] }]
}

MOD = Z_COMBINATOR[-> f { -> m { -> n {
  IF[IS_LESS_OR_EQUAL[n][m]][
    -> x {
      f[SUBTRACT[m][n]][n][x]
    }
  ][m]
}}}]

p to_integer(MOD[THREE][TWO])
