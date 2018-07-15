using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_orden_pago_cancelaciones_Data
    {
        public Boolean guardarDB(cp_orden_pago_cancelaciones_Info Info)
        {
            try
            {

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago_cancelaciones Entity = new cp_orden_pago_cancelaciones
                    {

                        IdEmpresa = Info.IdEmpresa,
                        Idcancelacion = Info.Secuencia = get_id(Info.IdEmpresa),
                        Secuencia = Info.Secuencia,
                        IdEmpresa_op = Info.IdEmpresa_op,
                        IdOrdenPago_op = Info.IdOrdenPago_op,
                        Secuencia_op = 1,
                        IdEmpresa_op_padre = Info.IdEmpresa_op_padre,
                        IdOrdenPago_op_padre = Info.IdOrdenPago_op_padre,
                        Secuencia_op_padre = Info.Secuencia_op_padre,
                        IdEmpresa_cxp = Info.IdEmpresa_cxp,
                        IdTipoCbte_cxp = Info.IdTipoCbte_cxp,
                        IdCbteCble_cxp = Info.IdCbteCble_cxp,
                        IdEmpresa_pago = Info.IdEmpresa_pago,
                        IdTipoCbte_pago = Info.IdTipoCbte_pago,
                        IdCbteCble_pago = Info.IdCbteCble_pago,
                        MontoAplicado = Info.MontoAplicado,
                        SaldoAnterior = Info.SaldoAnterior,
                        SaldoActual = Info.SaldoActual,
                        Observacion = Info.Observacion,
                        fechaTransaccion = DateTime.Now
                    };
                    Context.cp_orden_pago_cancelaciones.Add(Entity);
                    Context.SaveChanges();


                }
                return true;
            }
            catch (Exception )
            {
                
                throw ;
            }
        }
        public int get_id(int IdEmpresa)
        {
            try
            {
                int Id;
                using (Entities_cuentas_por_pagar Context=new Entities_cuentas_por_pagar())
                {
                    var select = Context.cp_orden_pago_cancelaciones.Count(q => q.IdEmpresa == IdEmpresa);
                    if (select == 0)
                    {
                        return Id = 1;
                    }

                    else
                    {
                        var select_ = (from t in Context.cp_orden_pago_cancelaciones
                                       where t.IdEmpresa == IdEmpresa
                                       select t.Idcancelacion).Max();
                        Id = Convert.ToInt32(select_.ToString()) + 1;
                        return Id;
                    }
                }

               
            }
            catch (Exception )
            {
               
                throw;
            }
        }

        public List<cp_orden_pago_cancelaciones_Info> Get_list_Cancelacion_x_CXP(int IdEmpresa_cxp, int IdTipoCbte_cxp, decimal IdCbteCble_cxp)
        {
            try
            {

                List<cp_orden_pago_cancelaciones_Info> Lst = new List<cp_orden_pago_cancelaciones_Info>();

                using (Entities_cuentas_por_pagar cxp = new Entities_cuentas_por_pagar())
                {
                    var consulta = from q in cxp.cp_orden_pago_cancelaciones
                                   where q.IdEmpresa_cxp == IdEmpresa_cxp
                                   && q.IdTipoCbte_cxp == IdTipoCbte_cxp
                                   && q.IdCbteCble_cxp == IdCbteCble_cxp
                                   select q;

                    foreach (var item in consulta)
                    {
                        cp_orden_pago_cancelaciones_Info info = new cp_orden_pago_cancelaciones_Info();

                        info.IdEmpresa = item.IdEmpresa;
                        info.Idcancelacion = item.Idcancelacion;
                        info.Secuencia = item.Secuencia;
                        info.IdEmpresa_cxp = item.IdEmpresa_cxp;
                        info.IdTipoCbte_cxp = item.IdTipoCbte_cxp;
                        info.IdCbteCble_cxp = item.IdCbteCble_cxp;
                        info.IdEmpresa_pago = item.IdEmpresa_pago;
                        info.IdTipoCbte_pago = item.IdTipoCbte_pago;
                        info.IdCbteCble_pago = item.IdCbteCble_pago;
                        info.MontoAplicado = Convert.ToDouble(item.MontoAplicado);
                        info.SaldoAnterior = Convert.ToDouble(item.SaldoAnterior);
                        info.SaldoActual = Convert.ToDouble(item.SaldoActual);

                        Lst.Add(info);
                    }
                }

                return Lst;
            }
            catch (Exception )
            {
                
                throw ;
            }
        }

    }
}
