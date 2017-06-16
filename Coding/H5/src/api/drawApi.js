import axios from 'axios'

const DrawApi = {

    getDrawData(){
        return axios.get('/draw/draw')
    }

}

export default DrawApi
