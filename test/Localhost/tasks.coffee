import dd from 'ddeyes'
import { createStore } from 'cfx.redux'
import { SagaMiddleware } from 'cfx.redux-saga'
import actions from './redux/actions'
import reducers from './redux/reducers'
import sagas from './redux/sagas'
import todoApp from './redux/index'
import { sleep } from './service'
import { local_login } from './service'

SagaMW = new SagaMiddleware()

store = createStore
  todoApp: reducers
, [
  SagaMW.getMidleware()
]

SagaMW.runSagas sagas

# todos
localRedux_todos = =>
  store.dispatch actions.clientStoreTodos()
  await sleep 2000
  dd store.getState()

# one todo
localRedux_oneTodo = =>
  local_login()
  .then (data) ->
    store.dispatch actions.clientStoreOnetodo
      objectId: data.objectId
    await sleep 2000
    dd store.getState()

# add todo
localRedux_addTodo = =>
  store.dispatch actions.clientStoreAddtodo
    username:'何S', password:'123456'
  await sleep 2000
  dd store.getState()

# update todo
localRedux_updateTodo = =>
  local_login()
  .then (data) ->
    store.dispatch actions.clientStoreUpdatetodo
      objectId: data.objectId, sessionToken: data.sessionToken, username: '何S', password: '123456'
    await sleep 2000
    dd store.getState()

# delete todo
localRedux_deleteTodo = =>
  local_login()
  .then (data) ->
    store.dispatch actions.clientStoreDeletetodo
      objectId: data.objectId, sessionToken: data.sessionToken
    await sleep 2000
    dd store.getState()

export {
  localRedux_todos
  localRedux_oneTodo
  localRedux_addTodo
  localRedux_updateTodo
  localRedux_deleteTodo
}
  
  
