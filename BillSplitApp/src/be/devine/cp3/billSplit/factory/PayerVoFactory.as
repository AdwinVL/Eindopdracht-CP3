package be.devine.cp3.billSplit.factory {
import be.devine.cp3.billSplit.vo.PayerVo;

public class PayerVoFactory
{
    public static function createPersonVOFromObject(payer:Object):PayerVo
    {
        var payerVo:PayerVo = new PayerVo();
        payerVo.name = payer.payerName.text;
        payerVo.percent = payer.totalAmount.text;
        return payerVo;
    }
}
}
