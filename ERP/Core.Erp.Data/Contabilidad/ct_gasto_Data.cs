using Core.Erp.Info.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Contabilidad
{
    public class ct_gasto_Data
    {
        public List<ct_gasto_Info> GetList(bool MostrarAnulado)
        {
            try
            {
                List<ct_gasto_Info> Lista = new List<ct_gasto_Info>();

                using (Entities_contabilidad db = new Entities_contabilidad())
                {
                    if (MostrarAnulado == false)
                    {
                        Lista = db.ct_gasto.Where(q => q.Estado == true).Select(q => new ct_gasto_Info
                        {
                            IdGasto = q.IdGasto,
                            IdEmpresa = q.IdEmpresa,
                            IdCtaCble = q.IdCtaCble,
                            Descripcion = q.Descripcion,
                            Estado = q.Estado                                              
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.ct_gasto.Select(q => new ct_gasto_Info
                        {
                            IdGasto = q.IdGasto,
                            IdEmpresa = q.IdEmpresa,
                            IdCtaCble = q.IdCtaCble,
                            Descripcion = q.Descripcion,
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

        public ct_gasto_Info GetInfo(int IdGasto)
        {
            try
            {
                ct_gasto_Info info = new ct_gasto_Info();

                using (Entities_contabilidad Context = new Entities_contabilidad())
                {
                    ct_gasto Entity = Context.ct_gasto.FirstOrDefault(q => q.IdGasto == IdGasto);
                    if (Entity == null) return null;
                    info = new ct_gasto_Info
                    {
                        IdGasto = Entity.IdGasto,
                        IdEmpresa = Entity.IdEmpresa,
                        IdCtaCble = Entity.IdCtaCble,
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

        public int GetId(int IdEmpresa)
        {
            try
            {
                int ID = 1;

                using (Entities_contabilidad db = new Entities_contabilidad())
                {
                    var lst = db.ct_gasto.Where(q => q.IdEmpresa == IdEmpresa).ToList();
                    if (lst.Count > 0)
                        ID = lst.Max(q => q.IdGasto) + 1;
                }

                return ID;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarDB(ct_gasto_Info info)
        {
            try
            {
                Entities_contabilidad db = new Entities_contabilidad();
                #region Cambio producto
                db.ct_gasto.Add(new ct_gasto
                {
                    IdEmpresa = info.IdEmpresa,
                    IdGasto = GetId(info.IdEmpresa),
                    Descripcion = info.Descripcion,
                    IdCtaCble = info.IdCtaCble,
                    Estado = true,
                    IdUsuario = info.IdUsuario,
                    Fecha_Transac = DateTime.Now
                });

                db.SaveChanges();
                #endregion

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool AnularDB(ct_gasto_Info info)
        {
            try
            {
                using (Entities_contabilidad db = new Entities_contabilidad())
                {
                    var Entity = db.ct_gasto.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdGasto == info.IdGasto).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Estado = false;
                    Entity.IdUsuarioUltAnu = info.IdUsuario;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Entity.MotivoAnu = info.MotiAnu;

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
