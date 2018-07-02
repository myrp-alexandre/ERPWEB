using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_cobro_Data
    {
        public List<cxc_cobro_Info> get_list(int IdEmpresa, int IdSucursal, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                List<cxc_cobro_Info> Lista;

                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    Lista = (from q in Context.vwcxc_cobro
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && Fecha_ini <= q.cr_fecha && q.cr_fecha <= Fecha_fin
                             orderby q.IdCobro
                             select new cxc_cobro_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdCobro = q.IdCobro,
                                 IdCliente = q.IdCliente,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 IdCobro_tipo = q.IdCobro_tipo,
                                 tc_descripcion = q.tc_descripcion,
                                 cr_fecha = q.cr_fecha,
                                 cr_TotalCobro = q.cr_TotalCobro,
                                 cr_estado = q.cr_estado,
                                 Su_Descripcion = q.Su_Descripcion
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public decimal get_id(int IdEmpesa, int IdSucursal)
        {
            try
            {
                decimal ID = 1;

                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {

                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
