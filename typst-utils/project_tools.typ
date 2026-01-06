#let init(body) = [
  #set page(margin: 40pt)
  #set text(font: "Aptos Display", size: 12pt, fill: black, weight: "regular")

  #show raw: set text(font: "Courier New", weight: "bold", size: 10pt)
  #set raw(theme: "Themes/InspiredGitHub.tmTheme")
  #body
]


#let wt(body, dsp: -10pt) = {
  set text(fill: white, size: 0.01pt)
  show raw: set text(fill: white, size: 0.01pt)
  v(dsp)
  text(body)
}


#let cmd_color(input, dsp: 0pt) = {
  let userIn = false
  let error = false
  v(2pt)
  set text(font: "Courier New", weight: "bold", size: 10pt, fill: rgb("#d1d1d1"))
  highlight(fill: rgb("#383838"), top-edge: 15pt, bottom-edge: -10pt, radius: 3pt, extent: 6pt)[

    #if type(input) == array {

      let max_len = 0
      for line in input {
        if line.len() > max_len {
          max_len = line.len()
        }
      }

      v(5pt)
      for line in input {

        let num_spaces = max_len - line.len()

        if line != " " {

          if line.split().at(0) == ">" {
            userIn = true
            error = false
          } else  if line.split().at(0) == "Exception" {
            userIn = false
            error = true
          } else {
            userIn = false
            error = false
          }

          h(7pt + dsp)
          for word in line.split() {
            if error {
              text(fill: rgb("#a83232"), word + " ")
            }
            else if (userIn or word == "Example.java" or word == "Example" or word == "ZipCrackerSingleThread") and word != ">" {
              text(fill: rgb("#58ad37"), word + " ")
            }
            else if word == "java" or word == "javac"{
              text(fill: rgb("#ad7a37"), word + " ")
            } else {
              text(word + " ")
            }
          }
        } else {
          h(7pt + dsp)
          text(" ")
          text(" ")
        }

        for i in range(num_spaces) {
          text(" ")
        }
        v(-1pt)
      }
    } else {
        if input.split().at(0) == ">" {
          userIn = true
          error = false
        } else  if input.split().at(0) == "Exception" {
          userIn = false
          error = true
        } else {
          userIn = false
          error = false
        }

        h(12pt + dsp)
        for word in input.split() {
          if error {
            text(fill: rgb("#a83232"), word + " ")
          }
          else if (userIn or word == "Example.java" or word == "Example" or word == "ZipCrackerSingleThread") and word != ">" {
            text(fill: rgb("#58ad37"), word + " ")
          }
          else if word == "java" or word == "javac"{
            text(fill: rgb("#ad7a37"), word + " ")
          } else {
            text(word + " ")
          }
        }
        v(3pt)
    }
 ]
 v(10pt)
}


#let uml(title, fields, methods) = {
  table(
  table.hline(),
  table.vline(),
  stroke: none,
  inset: 5pt,
  align: center,
  fill: rgb("#ffe1c4"),
  table.header(
    title,
  ),
  table.vline(),
  table.hline(start: 0),

  v(-5pt),
  for field in fields {
      v(-5pt)
      table.cell(align: left, field)
  },

  table.hline(start: 0),

  v(-5pt),
  for method in methods {
      v(-5pt)
      table.cell(align: left, method)
  },

  table.hline()
)
}


#let lp(class, lpNum, title) = {
  text[= CS-118#class Lab Problem #lpNum: #title]
  line(length: 100%, stroke: 0.5pt)
}

#let purpose(body) = [
  *PURPOSE: *
  #body
]

#let directions(body) = [
  #v(15pt)
  *DIRECTIONS: *
  #body
]

#let partA(body) = [
  #v(15pt)
  *DIRECTIONS: *
  #v(-5pt)
  === Part A (Due by end of first lab session)
  #v(0pt)
  #body
]

#let partB(body) = [
  #v(15pt)
  === Part B
  #v(0pt)
  #body
]

#let extra(title: "Extra", body) = [
  #v(15pt)
  *#title: *
  #body
]

#let example(io, text) = [
  #v(15pt)
  *EXAMPLE: *
  #text
  #cmd_color(io)
]

#let labRubric(docOverride: "Documentation", partAOverride: "Part A correct", partBOverride: "Part B correct", notes) = [
  #v(15pt)
  == RUBRIC:
  #v(5pt)

  #notes
  #v(0pt)

  *[1pt\]*
  #h(10pt)
  *#docOverride*
  #v(-5pt)
  *\[1pt\]*
  #h(10pt)
  *#partAOverride*
  #v(-5pt)
  *\[1pt\]*
  #h(10pt)
  *#partBOverride*

]


#let rubric(baseRubric, styleRubric, bonusRubric: none, wtRubric: none, ..notes) = {

  let baseTotal = baseRubric.at(0).sum()

  text[== RUBRIC:]
  v(5pt)
  text[(#baseTotal pts) *Base Functionality*]
  v(-5pt)
  for i in range(baseRubric.at(0).len()) {
    h(36pt)
    if baseRubric.at(0).at(i) != 0 {
      text[\[#baseRubric.at(0).at(i)\] #baseRubric.at(1).at(i)]
    } else {
      text[#baseRubric.at(1).at(i)]
    }
    v(-5pt)
  }

  let styleTotal = styleRubric.at(0).sum()

  v(10pt)
  text[(#styleTotal pts) *Style*]
  v(-5pt)
  for i in range(styleRubric.at(0).len()) {
    h(36pt)
    if styleRubric.at(0).at(i) != 0 {
      text[\[#styleRubric.at(0).at(i)\] #styleRubric.at(1).at(i)]
    } else {
      text[#styleRubric.at(1).at(i)]
    }
    v(-5pt)
  }

  if bonusRubric != none{
    let extraTotal = bonusRubric.at(0).sum()
    let extraPercent = extraTotal / 10

    v(10pt)
    text[(#extraTotal pts) *Extra Credit* (#extraTotal points == #extraPercent% additional credit in the course)]
    v(-5pt)
    for i in range(bonusRubric.at(0).len()) {
      h(36pt)
      if bonusRubric.at(0).at(i) != 0 {
        text[\[#bonusRubric.at(0).at(i)\] #bonusRubric.at(1).at(i)]
      } else {
        text[#bonusRubric.at(1).at(i)]
      }
      v(-5pt)
    }
  }

  if wtRubric != none{
    let wtTotal = wtRubric.at(0).sum()

    let wtPercent = wtTotal / 10
    wt[
      #text[(#wtTotal pts) *Extra Credit* (#wtTotal points == #wtPercent% additional credit in the course)]
      #v(0pt)
      #for i in range(wtRubric.at(0).len()) {
        h(36pt)
        text[\[#wtRubric.at(0).at(i)\] #wtRubric.at(1).at(i)]
        v(-5pt)
      }
    ]
  }

  v(15pt)
  text(weight: "semibold")[
  IMPORTANT NOTES:
  #v(-5pt)
  #line(length: 20%, stroke: 0.5pt)
  #if notes != none {
    v(0pt)
    set text(fill:  rgb("#b52424"))
    for x in notes.pos() {
      [- #x]
    }
    set text(fill: black)
  }
  #v(0pt)
  - Submissions that do not compile will receive a zero
  - Submissions with improperly cited AI  will receive a zero and an academic integrity violation
  - Submissions that are partially or fully copied from another submission will receive a zero and an academic integrity violation]
}

// exam stuff

#let title-state = state("title", "")

#let points = counter("points")

#let header() = [
  #grid(
    columns: (1fr, 1fr),
    align(center)[
      #text(size: 17pt)[
        #align(left)[
          #"Name:_____________________________"
        ]
      ]
    ],
    align(center)[
      #text(size: 17pt)[
        #align(right)[
          #grid(
            rows: (0pt, 20pt),
            align(center)[
              //#context title-state.get()
            ],
            align(right)[
              #"____ /" #context points.final().at(0) pts
            ]
          )
        ]
      ]
    ]
  )
]

#set page(header: [
  #context title-state.get()
])

#let setup(title) = {
  title-state.update(title)
}

#let spacer() = {
  v(10pt)
}





#let cur-question = state(
  "num_qs", 1
)


#let question(body, num_points) = context {
  cur-question.update(n => n + 1)
  points.update(points => points + num_points)
  let qnum = cur-question.get()
  box(
    align(left)[
      #grid(
        columns: (20pt, 1fr),
        rows: (auto),
        block[
          #text(weight: "bold")[#qnum.])
        ],
        block[
          #par()[#body (#num_points pts)]
        ]
      )
    ]
  )
}

#let c = counter("letter")

#let answer_indents = (1fr, 10fr, 1fr)


// maps a number into a tuple of 1fr units
// primarily used to make optional column passing to #multiple_choice easier
// input = 3 -> output = (1fr, 1fr, 1fr)
// input = 5 -> output = (1fr, 1fr, 1fr, 1fr, 1fr)
// etc.
#let _num_to_fr_units(num) = {
  range(num).map(i => 1fr)
}

#let multiple_choice(body, num_points, cols: 1, ..answers) = {

  let cols_type = type(cols)

  block[
    #c.update(0)
    #question(body, num_points)
    #v(5pt)
    #grid(
      columns: answer_indents,
      rows: (auto),
      "",
      block[
        #grid(
          columns: {
            if(cols_type) == int {
              _num_to_fr_units(cols)
            } else {
              cols
            }

          },
          rows: auto,
          column-gutter: 5pt,
          row-gutter: 15pt,
          // spread to arr and map
          ..answers.pos().map(answer => {
            c.step()
            block[
              #context c.display("a"). #" " #answer
            ]
          }
        )
      )
      ],
      "",
    )

  ]
}

#let matching(q_body, points, left_opts, right_opts) = {
  // left and right are shadows
  block[
    #c.update(0)
    #question(q_body, points)
    #spacer()
    #grid(
    // should sum to 12, to match answer_indents
    // 1st is just a spacer
      columns: (1fr, 4fr, 7fr),
      "",
      align(left)[
        #for word in left_opts {
          block[
            #"____" #word
            #spacer()
          ]
        }
      ],
      align(left)[
        #for x in right_opts {
          block[
            #c.step()
            #context c.display("a"). #" " #x
            #spacer()
          ]
        }
      ]
    )
  ]
}

// need better name
#let multi_true_false(q_body, points, ..statements) = {
  let num = counter("I")
  num.step() // counter starts with N, I, II, etc -> skip N?
  block[
    #question(q_body, points)
    #for statement in statements.pos() {
      block[

        #grid(
          // 1fr, 1fr, 9fr, 1fr
          columns: (42pt, 18pt, 9fr, 1fr),
          rows: (auto),
          "",
          block[
            #set text(font: "Libertinus Serif")
            #context num.display("I").
            #context num.step()
          ],
          statement,
          "______"
        )
      ]
    }
  ]
}



#let free_response(q_body, points, num_lines) = {
  question(q_body, points)
  for _ in range(num_lines) {
    v(15pt)
  }
}

#let short_answer(q_body, points, num_lines) = {
  question(q_body, points)
  grid(
    rows: auto,
    "",
    columns: (1fr, 10fr, 1fr),
    for _ in range(num_lines) {
      v(15pt)
      "___________________________________________________________________________"
    },
    ""
  )
}
// will simply extend the box to the edge of the code, can add white space if need it to be longer
#let code_block(raw_code) = {
  box(stroke: (paint: rgb("#d9d9d9"), thickness: 2pt, cap: "round"), inset: (8pt))[
      #raw_code
  ]
}
