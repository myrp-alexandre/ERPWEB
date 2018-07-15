using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_Conciliacion_Data
    {
        public List<ba_Conciliacion_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                List<ba_Conciliacion_Info> Lista;

                using (Entities_banco Context = new Entities_banco())
                {
                    Lista = (from q in Context.vwba_Conciliacion
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_ini <= q.co_Fecha
                             && q.co_Fecha <= Fecha_fin
                             orderby q.IdConciliacion descending
                             select new ba_Conciliacion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdConciliacion = q.IdConciliacion,
                                 IdBanco = q.IdBanco,
                                 IdPeriodo = q.IdPeriodo,
                                 co_Fecha = q.co_Fecha,
                                 IdEstado_Concil_Cat = q.IdEstado_Concil_Cat,
                                 co_SaldoContable_MesAnt = q.co_SaldoContable_MesAnt,
                                 co_totalIng = q.co_totalIng,
                                 co_totalEgr = q.co_totalEgr,
                                 co_SaldoContable_MesAct = q.co_SaldoContable_MesAct,
                                 co_SaldoBanco_EstCta = q.co_SaldoBanco_EstCta,
                                 co_SaldoBanco_anterior = q.co_SaldoBanco_anterior,
                                 Estado = q.Estado,
                                 co_Observacion = q.co_Observacion,
                                 ba_descripcion = q.ba_descripcion,
                                 IdCtaCble = q.IdCtaCble,
                                 Periodo = q.Periodo
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
