// express app
const express = require('express')
const app = express()
const port = 3000

const users = {
  1: 'jane',
  2: 'john',
  3: 'jody',
  4: 'jeff'
}
// routes
app.get('/:id', (req, res) => {
  const id = req.params.id
  if (id in users) {
    res.send(users[id])
  } else {
    res.sendStatus(404)
  }
})

app.listen(port, () => {
  console.log(`Time service listening at http://localhost:${port}`)
})
