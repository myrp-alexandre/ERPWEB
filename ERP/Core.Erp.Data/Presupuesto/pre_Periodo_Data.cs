using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Presupuesto
{
    public class pre_Periodo_Data
    {
        public List<pre_Periodo_Info> GetList(int IdEmpresa, bool MostrarAnulado)
        {
            try
            {
                List<pre_Periodo_Info> Lista = new List<pre_Periodo_Info>();

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    if (MostrarAnulado == false)
                    {
                        Lista = db.pre_PresupuestoPeriodo.Where(q => q.Estado == true && q.IdEmpresa == IdEmpresa).Select(q => new pre_Periodo_Info
                        {
                            IdPeriodo = q.IdPeriodo,
                            IdEmpresa = q.IdEmpresa,
                            Observacion = q.Observacion,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            EstadoCierre = q.EstadoCierre,
                            Estado = q.Estado,
                            Periodo = ""
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.pre_PresupuestoPeriodo.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new pre_Periodo_Info
                        {
                            IdPeriodo = q.IdPeriodo,
                            IdEmpresa = q.IdEmpresa,
                            Observacion = q.Observacion,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            EstadoCierre = q.EstadoCierre,
                            Estado = q.Estado,
                            Periodo = ""
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

        public pre_Periodo_Info GetInfo(int IdEmpresa, int IdPeriodo)
        {
            try
            {
                pre_Periodo_Info info = new pre_Periodo_Info();

                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_PresupuestoPeriodo Entity = Context.pre_PresupuestoPeriodo.Where(q => q.IdPeriodo == IdPeriodo && q.IdEmpresa == IdEmpresa).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new pre_Periodo_Info
                    {
                        IdPeriodo = Entity.IdPeriodo,
                        IdEmpresa = Entity.IdEmpresa,
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

        public pre_Periodo_Info GetInfo_UltimoPeriodoAbierto(int IdEmpresa)
        {
            try
            {
                pre_Periodo_Info info = new pre_Periodo_Info();

                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_PresupuestoPeriodo Entity = Context.pre_PresupuestoPeriodo.Where(q => q.IdEmpresa == IdEmpresa && q.EstadoCierre == true && q.Estado == true).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new pre_Periodo_Info
                    {
                        IdPeriodo = Entity.IdPeriodo,
                        IdEmpresa = Entity.IdEmpresa,
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
                    var Lista = db.pre_PresupuestoPeriodo.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdPeriodo);

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
        public bool GuardarBD(pre_Periodo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    db.pre_PresupuestoPeriodo.Add(new pre_PresupuestoPeriodo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdPeriodo = info.IdPeriodo = get_id(info.IdEmpresa),
                        Observacion = info.Observacion,
                        FechaInicio = info.FechaInicio,
                        FechaFin = info.FechaFin,
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

        public bool ModificarBD(pre_Periodo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_PresupuestoPeriodo entity = db.pre_PresupuestoPeriodo.Where(q => q.IdPeriodo == info.IdPeriodo && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Observacion = info.Observacion;
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

        public bool AnularBD(pre_Periodo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_PresupuestoPeriodo entity = db.pre_PresupuestoPeriodo.Where(q => q.IdPeriodo == info.IdPeriodo && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

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
