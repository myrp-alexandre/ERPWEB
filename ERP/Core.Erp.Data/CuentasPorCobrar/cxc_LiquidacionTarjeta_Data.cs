using Core.Erp.Info;
using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_LiquidacionTarjeta_Data
    {
        public List<cxc_LiquidacionTarjeta_Info> get_list(int IdEmpresa, int IdSucursal, bool MostrarAnulados)
        {
            try
            {
                List<cxc_LiquidacionTarjeta_Info> Lista = new List <cxc_LiquidacionTarjeta_Info >();
                var IdSucursalIni = IdSucursal == 0 ? 0 : IdSucursal;
                var IdSucursalFin = IdSucursal == 0 ? 99999 : IdSucursal;

                using (Entities_cuentas_por_cobrar db = new Entities_cuentas_por_cobrar())
                {
                    if (MostrarAnulados)
                        Lista = (from q in db.cxc_LiquidacionTarjeta
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal >= IdSucursalIni
                                 && q.IdSucursal <= IdSucursalFin
                                 orderby q.IdLiquidacion descending
                                 select new cxc_LiquidacionTarjeta_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdLiquidacion = q.IdLiquidacion,
                                     Fecha = q.Fecha,
                                     IdTarjeta = q.IdTarjeta,
                                     Estado = q.Estado,
                                     IdBanco = q.IdBanco,
                                     Observacion = q.Observacion,
                                     Valor = q.Valor
                                 }).ToList();
                    else
                        Lista = (from q in db.cxc_LiquidacionTarjeta
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal >= IdSucursalIni
                                 && q.IdSucursal <= IdSucursalFin
                                 && q.Estado == true
                                 orderby q.IdLiquidacion descending
                                 select new cxc_LiquidacionTarjeta_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdLiquidacion = q.IdLiquidacion,
                                     Fecha = q.Fecha,
                                     IdTarjeta = q.IdTarjeta,
                                     Estado = q.Estado,
                                     IdBanco = q.IdBanco,
                                     Observacion = q.Observacion,
                                     Valor = q.Valor
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa, int IdSucursal)
        {

            try
            {
                decimal ID = 1;
                using (Entities_cuentas_por_cobrar db = new Entities_cuentas_por_cobrar())
                {
                    var Lista = db.cxc_LiquidacionTarjeta.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal).Select(q => q.IdLiquidacion);

                    if (Lista.Count() > 0)
                        ID = Lista.Max() + 1;
                }
                return Convert.ToInt32(ID);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cxc_LiquidacionTarjeta_Info get_info(int IdEmpresa, int IdSucursal, decimal IdLiquidacion)
        {
            try
            {
                cxc_LiquidacionTarjeta_Info info = new cxc_LiquidacionTarjeta_Info();
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_LiquidacionTarjeta Entity = Context.cxc_LiquidacionTarjeta.Where(q => q.IdLiquidacion == IdLiquidacion && q.IdSucursal == IdSucursal && q.IdEmpresa == IdEmpresa).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new cxc_LiquidacionTarjeta_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdLiquidacion = Entity.IdSucursal,
                        IdBanco = Entity.IdBanco,
                        IdTarjeta = Entity.IdTarjeta,
                        Valor = Entity.Valor,
                        Fecha = Entity.Fecha,
                        Estado = Entity.Estado
                    };
                }

                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
