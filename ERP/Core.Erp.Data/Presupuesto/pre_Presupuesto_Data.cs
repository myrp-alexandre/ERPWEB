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
        public List<pre_Presupuesto_Info> get_list(int IdEmpresa, int IdSucursal, decimal IdPeriodo, bool MostrarAnulados)
        {
            try
            {
                List<pre_Presupuesto_Info> Lista;

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    if (MostrarAnulados == false)
                    {
                        Lista = db.vwpre_Presupuesto.Where(q => q.Estado == true && q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdPeriodo == IdPeriodo).Select(q => new pre_Presupuesto_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPresupuesto = q.IdPresupuesto,                            
                            IdSucursal = q.IdSucursal,
                            Su_Descripcion = q.Su_Descripcion,
                            IdPeriodo = q.IdPeriodo,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            IdGrupo = q.IdGrupo,
                            Descripcion = q.Descripcion,
                            Observacion = q.Observacion,
                            Estado = q.Estado,
                            MontoSolicitado = q.MontoSolicitado,
                            MontoAprobado = q.MontoAprobado

                        }).ToList();
                    }
                    else
                    {
                        Lista = db.vwpre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdPeriodo == IdPeriodo).Select(q => new pre_Presupuesto_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdPresupuesto = q.IdPresupuesto,
                            IdSucursal = q.IdSucursal,
                            Su_Descripcion = q.Su_Descripcion,
                            IdPeriodo = q.IdPeriodo,
                            FechaInicio = q.FechaInicio,
                            FechaFin = q.FechaFin,
                            IdGrupo = q.IdGrupo,
                            Descripcion = q.Descripcion,
                            Observacion = q.Observacion,
                            Estado = q.Estado,
                            MontoSolicitado = q.MontoSolicitado,
                            MontoAprobado = q.MontoAprobado

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
                        IdPeriodo = Entity.IdPeriodo,
                        IdGrupo = Entity.IdGrupo,
                        Observacion = Entity.Observacion,
                        MontoAprobado = Entity.MontoAprobado,
                        MontoSolicitado = Entity.MontoSolicitado,
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
                    var Lista = db.pre_Presupuesto.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdGrupo);

                    if (Lista.Count() > 0)
                        ID = Lista.Max() + 1;
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
                        IdGrupo = info.IdGrupo,
                        IdPeriodo = info.IdPeriodo,
                        Observacion =  info.Observacion,
                        MontoSolicitado = info.MontoSolicitado,
                        MontoAprobado = info.MontoAprobado,
                        Estado = true,
                        IdUsuarioCreacion = info.IdUsuarioCreacion,
                        FechaCreacion = DateTime.Now
                    });

                    if (info.ListaPresupuestoDet != null)
                    {
                        int Secuencia = 1;
                        foreach (var item in info.ListaPresupuestoDet)
                        {
                            pre_Rubro EntityRubro = db.pre_Rubro.Where(q => q.IdRubro == item.IdRubro && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();                            

                            db.pre_PresupuestoDet.Add(new pre_PresupuestoDet
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdPresupuesto = info.IdPresupuesto,
                                Secuencia = Secuencia++,
                                IdRubro = item.IdRubro,
                                IdCtaCble = EntityRubro.IdCtaCble,
                                Cantidad = item.Cantidad,
                                Monto = item.Monto
                            });

                        }
                    }
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
                    entity.IdPeriodo = info.IdPeriodo;
                    entity.IdGrupo = info.IdGrupo;
                    entity.Observacion = info.Observacion;
                    entity.MontoSolicitado = 0;
                    entity.IdUsuarioModificacion = info.IdUsuarioModificacion;
                    entity.FechaModificacion = DateTime.Now;

                    var lst_PresupuestoDet = db.pre_PresupuestoDet.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdPresupuesto == info.IdPresupuesto).ToList();
                    db.pre_PresupuestoDet.RemoveRange(lst_PresupuestoDet);

                    if (info.ListaPresupuestoDet != null)
                    {
                        int Secuencia = 1;
                        //decimal monto_solicitado = 0;

                        foreach (var item in info.ListaPresupuestoDet)
                        {
                            //monto_solicitado = monto_solicitado + item.Monto;
                            db.pre_PresupuestoDet.Add(new pre_PresupuestoDet
                            {
                                Secuencia = Secuencia++,
                                IdRubro = item.IdRubro,
                                IdCtaCble = item.IdCtaCble,
                                Cantidad = item.Cantidad,
                                Monto = item.Monto
                            });
                        }

                        //entity.MontoSolicitado = monto_solicitado;
                    }
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
