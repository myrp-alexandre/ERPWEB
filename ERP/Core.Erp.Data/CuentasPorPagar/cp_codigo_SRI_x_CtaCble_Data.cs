using Core.Erp.Info.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorPagar
{
    public class cp_codigo_SRI_x_CtaCble_Data
    {
        public cp_codigo_SRI_x_CtaCble_Info get_info(int idCodigo_SRI, int IdEmpresa)
        {
            try
            {
                cp_codigo_SRI_x_CtaCble_Info info = new cp_codigo_SRI_x_CtaCble_Info();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_codigo_SRI_x_CtaCble Entity = Context.cp_codigo_SRI_x_CtaCble.FirstOrDefault(q => q.idCodigo_SRI == idCodigo_SRI && q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new cp_codigo_SRI_x_CtaCble_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        idCodigo_SRI = Entity.idCodigo_SRI,
                        IdCtaCble = Entity.IdCtaCble
                        
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(cp_codigo_SRI_x_CtaCble_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_codigo_SRI_x_CtaCble Entity = new cp_codigo_SRI_x_CtaCble
                    {
                        idCodigo_SRI = info.idCodigo_SRI,
                        IdEmpresa = info.IdEmpresa,
                        IdCtaCble = info.IdCtaCble, fecha_UltMod = DateTime.Now                     
                    };
                    Context.cp_codigo_SRI_x_CtaCble.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool eliminarDB(int idCodigo_SRI, int IdEmpresa)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Context.Database.ExecuteSqlCommand("delete cp_codigo_SRI_x_CtaCble where idCodigo_SRI = "+idCodigo_SRI+"  and IdEmpresa =" +IdEmpresa);
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
