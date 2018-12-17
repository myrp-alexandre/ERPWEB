using Core.Erp.Data.Inventario;
using Core.Erp.Info.Presupuesto;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Presupuesto
{
    public class pre_Grupo_Data
    {
        public List<pre_Grupo_Info>get_list(int IdEmpresa, bool MostrarAnulados)
        {
            try
            {
                List<pre_Grupo_Info> Lista;

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    if (MostrarAnulados == false)
                    {
                        Lista = db.pre_Grupo.Where(q => q.Estado == true && q.IdEmpresa == IdEmpresa).Select(q => new pre_Grupo_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdGrupo = q.IdGrupo,
                            Descripcion = q.Descripcion,
                            Estado = q.Estado,
                            IdUsuarioCreacion = q.IdUsuarioCreacion,
                            IdUsuarioModificacion = q.IdUsuarioModificacion,
                            IdUsuarioAnulacion = q.IdUsuarioAnulacion,
                            MotivoAnulacion = q.MotivoAnulacion

                        }).ToList();
                    }
                    else
                    {
                        Lista = db.pre_Grupo.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new pre_Grupo_Info                        
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdGrupo = q.IdGrupo,
                            Descripcion = q.Descripcion,
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

        public List<pre_Grupo_Info> get_list_x_CtaCble(int IdEmpresa, int IdSucursal, string IdCtaCble, DateTime Fecha)
        {
            try
            {
                List<pre_Grupo_Info> Lista;

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    Lista = db.vwpre_Grupo_x_CtaCble.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdCtaCble == IdCtaCble
                    && (Fecha >= q.FechaInicio  && Fecha<= q.FechaFin ) ).Select(q => new pre_Grupo_Info
                    {
                        IdGrupo = q.IdGrupo,
                        Descripcion = q.Descripcion
                    }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public pre_Grupo_Info get_info(int IdEmpresa, int IdGrupo)
        {
            try
            {
                pre_Grupo_Info info = new pre_Grupo_Info();
                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_Grupo Entity = Context.pre_Grupo.Where(q => q.IdGrupo == IdGrupo && q.IdEmpresa == IdEmpresa).FirstOrDefault();                   

                    if (Entity == null) return null;
                    info = new pre_Grupo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdGrupo = Entity.IdGrupo,
                        Descripcion = Entity.Descripcion,
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
                    var Lista = db.pre_Grupo.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdGrupo);

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
        public bool GuardarBD(pre_Grupo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {                   
                    db.pre_Grupo.Add(new pre_Grupo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdGrupo = info.IdGrupo = get_id(info.IdEmpresa),
                        Descripcion = info.Descripcion,
                        Estado = true,
                        IdUsuarioCreacion = info.IdUsuarioCreacion,
                        FechaCreacion = DateTime.Now
                    });

                    //detalle
                    if (info.ListaGrupoDetalle != null)
                    {
                        int Secuencia = 1;
                        foreach (var item in info.ListaGrupoDetalle)
                        {
                            db.pre_Grupo_x_seg_usuario.Add(new pre_Grupo_x_seg_usuario
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdGrupo = info.IdGrupo,
                                Secuencia = Secuencia++,
                                IdUsuario = item.IdUsuario,
                                AsignaCuentas = item.AsignaCuentas
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

        public bool ModificarBD(pre_Grupo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_Grupo entity = db.pre_Grupo.Where(q => q.IdGrupo == info.IdGrupo && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Descripcion = info.Descripcion;
                    entity.IdUsuarioModificacion = info.IdUsuarioModificacion;
                    entity.FechaModificacion = DateTime.Now;

                    var lst_det_grupo = db.pre_Grupo_x_seg_usuario.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdGrupo == info.IdGrupo).ToList();
                    db.pre_Grupo_x_seg_usuario.RemoveRange(lst_det_grupo);

                    if (info.ListaGrupoDetalle != null)
                    {
                        int Secuencia = 1;

                        foreach (var item in info.ListaGrupoDetalle)
                        {
                            db.pre_Grupo_x_seg_usuario.Add(new pre_Grupo_x_seg_usuario
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdGrupo = info.IdGrupo,
                                Secuencia = Secuencia++,
                                IdUsuario = item.IdUsuario,
                                AsignaCuentas = item.AsignaCuentas
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

        public bool AnularBD(pre_Grupo_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_Grupo entity = db.pre_Grupo.Where(q => q.IdGrupo == info.IdGrupo && q.IdEmpresa == info.IdEmpresa).FirstOrDefault();

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

        public List<pre_Grupo_Info> GetList_x_Usuario(int IdEmpresa, string IdUsuario)
        {
            try
            {
                List<pre_Grupo_Info> Lista = new List<pre_Grupo_Info>();

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    Lista = db.vwpre_Grupo.Where(q => q.IdEmpresa == IdEmpresa && q.IdUsuario == IdUsuario && q.Estado == true).Select(q => new pre_Grupo_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdGrupo = q.IdGrupo,
                        Descripcion = q.Descripcion,
                        Estado = q.Estado
                    }).ToList();

                    return Lista;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
