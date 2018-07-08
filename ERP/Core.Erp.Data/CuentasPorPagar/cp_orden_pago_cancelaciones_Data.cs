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
                        Secuencia_op = Info.Secuencia_op,
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
            catch (Exception e)
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

        public List<cp_orden_pago_det_Info> Get_list_Cancelacion_x_CXP(int IdEmpresa_cxp, int IdTipoCbte_cxp, decimal IdCbteCble_cxp)
        {
            try
            {

                List<cp_orden_pago_det_Info> Lista = new List<cp_orden_pago_det_Info>();

                using (Entities_cuentas_por_pagar cxp = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in cxp.vwcp_orden_pago_con_cancelacion
                                   where q.IdEmpresa_cxp == IdEmpresa_cxp
                                   && q.IdTipoCbte_cxp == IdTipoCbte_cxp
                                   && q.IdCbteCble_cxp == IdCbteCble_cxp
                                        select new
                             cp_orden_pago_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdOrdenPago = q.IdOrdenPago,
                                 IdTipoCbte_cxp = q.IdTipoCbte_cxp,
                                 IdCbteCble_cxp = q.IdCbteCble_cxp,
                                 IdEntidad = q.IdEntidad,
                                 IdPersona = q.IdPersona,
                                 IdTipo_op = q.IdTipo_op,
                                 IdEstadoAprobacion = q.IdEstadoAprobacion,
                                 Valor_a_pagar = q.Valor_a_pagar,
                                 Valor_estimado_a_pagar_OP = q.Valor_a_pagar,
                                 Total_cancelado_OP = q.Valor_a_pagar,
                                 Nom_Beneficiario = q.pe_nombreCompleto, 
                                 Referencia=q.Observacion
                                 
                             }).ToList();


                }

                return Lista;
            }
            catch (Exception ex)
            {
                
                throw ;
            }
        }

    }
}
