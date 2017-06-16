import axios from 'axios'
import * as API from './urls'

export default {
  getProducts (callback)
  {
    axios.get('/product/all').then(res =>
    {
      callback(res.data)
    })
  },

  buyProducts (products, successHandle, errorHandle)
  {
    axios.post(API.productBuy, products)
      .then(res =>
      {
        if (Math.random() > 0.5)
        {
          successHandle(res)
        } else {
          errorHandle(res)
        }
      })
      .catch(error => errorHandle(error))
  }
}
