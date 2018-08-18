using Core.Erp.Info.Reportes.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Banco
{
    public class BAN_007_Data
    {
        public List<BAN_007_Info> get_list(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                List<BAN_007_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWBAN_007
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipocbte == IdTipoCbte
                             && q.IdCbteCble == IdCbteCble
                             select new BAN_007_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipocbte = q.IdTipocbte,
                                 IdCbteCble = q.IdCbteCble,
                                 cb_Cheque = q.cb_Cheque,
                                 cb_Fecha = q.cb_Fecha,
                                 cb_FechaCheque = q.cb_FechaCheque,
                                 cb_Observacion = q.cb_Observacion,
                                 cb_Valor = q.cb_Valor,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 ca_descripcion = q.ca_descripcion,
                                 ba_descripcion = q.ba_descripcion,
                                 Estado = q.Estado,
                                 IdBanco = q.IdBanco,
                                 IdCatalogo = q.IdCatalogo,
                                 IdPersona_Girado_a = q.IdPersona_Girado_a,
                                 IdRow = q.IdRow,
                                 Nombre = q.Nombre
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
