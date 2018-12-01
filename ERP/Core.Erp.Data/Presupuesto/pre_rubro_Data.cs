using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Presupuesto
{
    public class pre_rubro_Data
    {
        public List<pre_rubro_Info> GetList(int IdEmpresa, bool MostrarAnulado)
        {
            try
            {
                List<pre_rubro_Info> Lista = new List<pre_rubro_Info>();

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    if (MostrarAnulado == false)
                    {
                        Lista = db.pre_rubro.Where(q => q.Estado == true).Select(q => new pre_rubro_Info
                        {
                            IdRubro = q.IdRubro,
                            Descripcion = q.Descripcion,
                            IdCtaCble = q.IdCtaCble,
                            Estado = q.Estado
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.pre_rubro.Select(q => new pre_rubro_Info
                        {
                            IdRubro = q.IdRubro,
                            Descripcion = q.Descripcion,
                            IdCtaCble = q.IdCtaCble,
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

        public pre_rubro_Info GetInfo(int IdRubro)
        {
            try
            {
                pre_rubro_Info info = new pre_rubro_Info();

                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_rubro Entity = Context.pre_rubro.FirstOrDefault(q => q.IdRubro == IdRubro);
                    if (Entity == null) return null;
                    info = new pre_rubro_Info
                    {
                        IdRubro = Entity.IdRubro,
                        Descripcion = Entity.Descripcion,
                        IdCtaCble = Entity.IdCtaCble,
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
                    var Lista = db.pre_rubro.Select(q => q.IdRubro);

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
        public bool GuardarBD(pre_rubro_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    db.pre_rubro.Add(new pre_rubro
                    {
                        IdRubro = get_id(info.IdEmpresa),
                        Descripcion = info.Descripcion,
                        IdCtaCble = info.IdCtaCble,
                        Estado = info.Estado,
                        IdUsuarioCreacion = info.IdUsuario,
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

        public bool ModificarBD(pre_rubro_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_rubro entity = db.pre_rubro.Where(q => q.IdRubro == info.IdRubro).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Descripcion = info.Descripcion;
                    entity.IdCtaCble = info.IdCtaCble;
                    entity.IdUsuarioModificacion = info.IdUsuario;
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

        public bool AnularBD(pre_rubro_Info info)
        {
            try
            {
                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    pre_rubro entity = db.pre_rubro.Where(q => q.IdRubro == info.IdRubro).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Estado = info.Estado;
                    entity.IdUsuarioAnulacion = info.IdUsuario;
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
