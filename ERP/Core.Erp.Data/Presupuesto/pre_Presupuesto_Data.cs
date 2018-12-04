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
                        Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.FechaInicio >= FechaInicio && q.FechaFin <= FechaFin && q.Estado == true ).Select(q => new pre_Presupuesto_Info
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
                        Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.FechaInicio >= FechaInicio && q.FechaFin <= FechaFin).Select(q => new pre_Presupuesto_Info
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
            catch (Exception)
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

        public bool GuardarBD(pre_Presupuesto_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    db.pre_Presupuesto.Add(new pre_Presupuesto
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdPresupuesto = info.IdPresupuesto = get_id(info.IdEmpresa),
                        IdSucursal = info.IdSucursal,
                        Observacion = info.Observacion,
                        FechaInicio = info.FechaInicio,
                        FechaFin = info.FechaInicio,
                        EstadoCierre = info.EstadoCierre,
                        Estado = true,
                        IdUsuarioCreacion = info.IdUsuarioCreacion,
                        FechaCreacion = DateTime.Now
                    });

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ModificarBD(pre_Presupuesto_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_Presupuesto entity = db.pre_Presupuesto.Where(q => q.IdPresupuesto == info.IdPresupuesto && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.IdSucursal = info.IdSucursal;
                    entity.FechaInicio = info.FechaInicio;
                    entity.FechaFin = info.FechaFin;
                    entity.EstadoCierre = info.EstadoCierre;
                    entity.IdUsuarioModificacion = info.IdUsuarioModificacion;
                    entity.FechaModificacion = DateTime.Now;

                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool AnularBD(pre_Presupuesto_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_Presupuesto entity = db.pre_Presupuesto.Where(q => q.IdPresupuesto == info.IdPresupuesto && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Estado = false;
                    entity.IdUsuarioAnulacion = info.IdUsuarioAnulacion;
                    entity.FechaAnulacion = DateTime.Now;
                    entity.MotivoAnulacion = info.MotivoAnulacion;

                    db.SaveChanges();
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
