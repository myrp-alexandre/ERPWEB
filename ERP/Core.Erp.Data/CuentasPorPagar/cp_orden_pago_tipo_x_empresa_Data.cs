using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Core.Erp.Info.CuentasPorPagar;

namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_orden_pago_tipo_x_empresa_Data
    {

        public List<cp_orden_pago_tipo_x_empresa_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<cp_orden_pago_tipo_x_empresa_Info> Lista;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.cp_orden_pago_tipo_x_empresa
                             where q.IdEmpresa == IdEmpresa
                             select new cp_orden_pago_tipo_x_empresa_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipo_op = q.IdTipo_op,
                                 IdCtaCble = q.IdCtaCble,
                                 IdCentroCosto = q.IdCentroCosto,
                                 IdTipoCbte_OP = q.IdTipoCbte_OP,
                                 IdTipoCbte_OP_anulacion = q.IdTipoCbte_OP_anulacion,
                                 IdEstadoAprobacion = q.IdEstadoAprobacion,
                                 Buscar_FactxPagar = q.Buscar_FactxPagar,
                                 IdCtaCble_Credito = q.IdCtaCble_Credito,
                                 Dispara_Alerta = q.Dispara_Alerta

                                
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public cp_orden_pago_tipo_x_empresa_Info get_info(int IdEmpresa, string IdTipo_op)
        {
            try
            {
                cp_orden_pago_tipo_x_empresa_Info info = new cp_orden_pago_tipo_x_empresa_Info();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago_tipo_x_empresa q = Context.cp_orden_pago_tipo_x_empresa.FirstOrDefault(v => v.IdEmpresa == IdEmpresa& v.IdTipo_op== IdTipo_op);
                    if (q == null) return null;
                    info = new cp_orden_pago_tipo_x_empresa_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdTipo_op = q.IdTipo_op,
                        IdCtaCble = q.IdCtaCble,
                        IdCentroCosto = q.IdCentroCosto,
                        IdTipoCbte_OP = q.IdTipoCbte_OP,
                        IdTipoCbte_OP_anulacion = q.IdTipoCbte_OP_anulacion,
                        IdEstadoAprobacion = q.IdEstadoAprobacion,
                        Buscar_FactxPagar = q.Buscar_FactxPagar,
                        IdCtaCble_Credito = q.IdCtaCble_Credito,
                        Dispara_Alerta = q.Dispara_Alerta
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, decimal IdOrdenPago)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    string comando = "delete cp_orden_pago_tipo_x_empresa where IdEmpresa = " + IdEmpresa + " and IdOrdenPago = " + IdOrdenPago;
                    Context.Database.ExecuteSqlCommand(comando);
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(List<cp_orden_pago_tipo_x_empresa_Info> Lista)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    foreach (var item in Lista)
                    {
                        cp_orden_pago_tipo_x_empresa Entity = new cp_orden_pago_tipo_x_empresa
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdTipo_op = item.IdTipo_op,
                            IdCtaCble = item.IdCtaCble,
                            IdCentroCosto = item.IdCentroCosto,
                            IdTipoCbte_OP = item.IdTipoCbte_OP,
                            IdTipoCbte_OP_anulacion = item.IdTipoCbte_OP_anulacion,
                            IdEstadoAprobacion = item.IdEstadoAprobacion,
                            Buscar_FactxPagar = item.Buscar_FactxPagar,
                            IdCtaCble_Credito = item.IdCtaCble_Credito,
                            Dispara_Alerta = item.Dispara_Alerta
                        };
                        Context.cp_orden_pago_tipo_x_empresa.Add(Entity);
                    }
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
