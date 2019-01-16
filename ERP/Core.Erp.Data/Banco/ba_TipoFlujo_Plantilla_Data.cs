using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_TipoFlujo_Plantilla_Data
    {
        public List<ba_TipoFlujo_Plantilla_Info> get_list(int IdEmpresa, bool MostrarAnulados)
        {
            try
            {
                List<ba_TipoFlujo_Plantilla_Info> Lista;

                using (Entities_banco db = new Entities_banco())
                {
                    if (MostrarAnulados == false)
                    {
                        Lista = db.ba_TipoFlujo_Plantilla.Where(q => q.Estado == true && q.IdEmpresa == IdEmpresa).Select(q => new ba_TipoFlujo_Plantilla_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPlantilla = q.IdPlantilla,
                            Descripcion = q.Descripcion,                            
                            Desde = q.Desde,
                            Hasta = q.Hasta,
                            Estado = q.Estado
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.ba_TipoFlujo_Plantilla.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new ba_TipoFlujo_Plantilla_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPlantilla = q.IdPlantilla,
                            Descripcion = q.Descripcion,
                            Desde = q.Desde,
                            Hasta = q.Hasta,
                            Estado = q.Estado
                        }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa)
        {

            try
            {
                decimal ID = 1;
                using (Entities_banco db = new Entities_banco())
                {
                    var Lista = db.ba_TipoFlujo_Plantilla.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdPlantilla);

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

        public ba_TipoFlujo_Plantilla_Info get_info(int IdEmpresa, int IdPlantilla)
        {
            try
            {
                ba_TipoFlujo_Plantilla_Info info = new ba_TipoFlujo_Plantilla_Info();
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_TipoFlujo_Plantilla Entity = Context.ba_TipoFlujo_Plantilla.Where(q => q.IdPlantilla == IdPlantilla && q.IdEmpresa == IdEmpresa).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new ba_TipoFlujo_Plantilla_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdPlantilla = Entity.IdPlantilla,
                        Descripcion = Entity.Descripcion,
                        Desde = Entity.Desde,
                        Hasta = Entity.Hasta,
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
