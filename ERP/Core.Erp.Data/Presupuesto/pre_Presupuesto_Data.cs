using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Presupuesto
{
    public class pre_Presupuesto_Data
    {
        public List<pre_Presupuesto_Info> get_list(int IdEmpresa, int IdSucursal, DateTime FechaInicio, DateTime FechaFin, bool MostrarAnulados)
        {
            try
            {
                List<pre_Presupuesto_Info> Lista;

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    if (MostrarAnulados == false)
                    {
                        Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa ==IdEmpresa && q.Estado == true ).Select(q => new pre_Presupuesto_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPresupuesto = q.IdPresupuesto,
                            IdSucursal = q.IdSucursal,
                            Observacion = q.Observacion,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            EstadoCierre = q.EstadoCierre,
                            Estado = q.Estado,
                            IdUsuarioCreacion = q.IdUsuarioCreacion,
                            IdUsuarioModificacion = q.IdUsuarioModificacion,
                            IdUsuarioAnulacion = q.IdUsuarioAnulacion,
                            MotivoAnulacion = q.MotivoAnulacion
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new pre_Presupuesto_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPresupuesto = q.IdPresupuesto,
                            IdSucursal = q.IdSucursal,
                            Observacion = q.Observacion,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            EstadoCierre = q.EstadoCierre,
                            Estado = q.Estado,
                            IdUsuarioCreacion = q.IdUsuarioCreacion,
                            IdUsuarioModificacion = q.IdUsuarioModificacion,
                            IdUsuarioAnulacion = q.IdUsuarioAnulacion,
                            MotivoAnulacion = q.MotivoAnulacion
                        }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public pre_Presupuesto_Info get_info(int IdEmpresa, int IdPresupuesto)
        {
            try
            {
                pre_Presupuesto_Info info = new pre_Presupuesto_Info();

                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_Presupuesto Entity = Context.pre_Presupuesto.Where(q => q.IdPresupuesto == IdPresupuesto && q.IdEmpresa == IdEmpresa).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new pre_Presupuesto_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdPresupuesto = Entity.IdPresupuesto,
                        IdSucursal = Entity.IdSucursal,
                        Observacion = Entity.Observacion,
                        FechaInicio = Entity.FechaInicio,
                        FechaFin = Entity.FechaFin,
                        EstadoCierre = Entity.EstadoCierre,
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
        public int get_id(int IdEmpresa)
        {

            try
            {
                int ID = 1;
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    var Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdPresupuesto);

                    if (Lista.Count() > 0)
                        ID = Convert.ToInt32(Lista.Max() + 1);
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
