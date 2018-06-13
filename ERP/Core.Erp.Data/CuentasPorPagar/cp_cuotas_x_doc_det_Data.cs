using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_cuotas_x_doc_det_Data
    {
        public List<cp_cuotas_x_doc_det_Info> Get_list_cuotas_x_doc_det(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                List<cp_cuotas_x_doc_det_Info> Lista;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.cp_cuotas_x_doc_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdCuota == IdCuota
                             select new cp_cuotas_x_doc_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCuota = q.IdCuota,
                                 Secuencia = q.Secuencia,
                                 Num_cuota = q.Num_cuota,
                                 Fecha_vcto_cuota = q.Fecha_vcto_cuota,
                                 Valor_cuota = q.Valor_cuota,
                                 Observacion = q.Observacion,
                                 Estado = q.Estado,
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool EliminarDB(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    string comando = "delete cp_cuotas_x_doc_det where IdEmpresa = " + IdEmpresa + " and IdCuota = " + IdCuota;
                    Context.Database.ExecuteSqlCommand(comando);
                }

                return true;
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool GuardarDB(List<cp_cuotas_x_doc_det_Info> Lista)
        {
            try
            {
                int sec = 1;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    foreach (var item in Lista)
                    {
                        cp_cuotas_x_doc_det Entity = new cp_cuotas_x_doc_det
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdCuota = item.IdCuota,
                            Secuencia = sec,
                            Num_cuota = item.Num_cuota,
                            Fecha_vcto_cuota = item.Fecha_vcto_cuota,
                            Valor_cuota = item.Valor_cuota,
                            Observacion = item.Observacion,
                            Estado = item.Estado,
                            Secuencia_op = sec++
                        };
                        Context.cp_cuotas_x_doc_det.Add(Entity);
                    }
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool ModificarDB_campos_op(cp_cuotas_x_doc_det_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_cuotas_x_doc_det Entity = Context.cp_cuotas_x_doc_det.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdCuota == info.IdCuota && q.Secuencia == info.Secuencia);
                    if (Entity != null)
                    {
                        Entity.IdEmpresa_op = info.IdEmpresa_op;
                        Entity.IdOrdenPago = info.IdOrdenPago;
                        Entity.Secuencia_op = info.Secuencia_op;
                        Context.SaveChanges();
                    }
                }

                return true;
            }
            catch (Exception )
            {
                throw;
            }
        }
    }
}
