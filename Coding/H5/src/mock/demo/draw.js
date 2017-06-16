const draws = [
    {
        reason: '购房',
        quota: '20000.00',
        balance: '35000.00',
        state: 1
    },
    {
        reason: '大病',
        quota: '20000.00',
        balance: '12000.00',
        state: 1
    },
    {
        reason: '租房',
        quota: '9000.00',
        balance: '0.00',
        state: 0
    },
    {
        reason: '租房',
        quota: '5555.00',
        balance: '1.00',
        state: 0
    }
]

module.exports = {
    api: '/draw/draw',
    response:(req, res)=>{
        res.json({
            success: true,
            data: draws
        });
    }
}
