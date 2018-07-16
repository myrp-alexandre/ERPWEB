using Core.Erp.Info.Reportes.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Banco
{
    public class BAN_006_Data
    {
        public List<BAN_006_Info> get_list(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                List<BAN_006_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWBAN_006
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipoCbte == IdTipoCbte
                             && q.IdCbteCble == IdCbteCble
                             select new BAN_006_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipoCbte = q.IdTipoCbte,
                                 IdCbteCble = q.IdCbteCble,
                                 secuencia = q.secuencia,
                                 cb_Cheque = q.cb_Cheque,
                                 cb_Fecha = q.cb_Fecha,
                                 cb_giradoA = q.cb_giradoA,
                                 cb_Observacion = q.cb_Observacion,
                                 cb_Valor = q.cb_Valor,
                                 IdCtaCble = q.IdCtaCble,
                                 pc_Cuenta = q.pc_Cuenta,
                                 dc_Valor_Debe = q.dc_Valor_Debe,
                                 dc_Valor = q.dc_Valor,
                                 dc_Valor_Haber = q.dc_Valor_Haber,
                                 Descripcion_Ciudad = q.Descripcion_Ciudad,
                                 ValorEnLetras = q.ValorEnLetras
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
