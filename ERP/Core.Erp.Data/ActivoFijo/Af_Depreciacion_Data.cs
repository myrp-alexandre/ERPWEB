using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.ActivoFijo
{
    public class Af_Depreciacion_Data
    {
        public List<Af_Depreciacion_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<Af_Depreciacion_Info> Lista;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    if(mostrar_anulados)
                        Lista=(from q in Context.Af_Depreciacion
                               where q.IdEmpresa == IdEmpresa
                               select new Af_Depreciacion_Info
                               {
                                   IdEmpresa = q.IdEmpresa,
                                   IdDepreciacion = q.IdDepreciacion,
                                   IdTipoDepreciacion = q.IdTipoDepreciacion,
                                   IdPeriodo = q.IdPeriodo,
                                    Cod_Depreciacion = q.Cod_Depreciacion,
                                    Descripcion = q.Descripcion,
                                    Estado = q.Estado,
                                    Fecha_Depreciacion = q.Fecha_Depreciacion,
                                    Num_Act_Depre = q.Num_Act_Depre,
                                    Valor_Tot_Act = q.Valor_Tot_Act,
                                    Valor_Tot_Depre = q.Valor_Tot_Depre,
                                    Valor_Tot_DepreAcum = q.Valor_Tot_DepreAcum,
                                    Valot_Tot_Importe = q.Valot_Tot_Importe
                               }).ToList();
                    else
                        Lista = (from q in Context.Af_Depreciacion
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new Af_Depreciacion_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdDepreciacion = q.IdDepreciacion,
                                     IdTipoDepreciacion = q.IdTipoDepreciacion,
                                     IdPeriodo = q.IdPeriodo,
                                     Cod_Depreciacion = q.Cod_Depreciacion,
                                     Descripcion = q.Descripcion,
                                     Estado = q.Estado,
                                     Fecha_Depreciacion = q.Fecha_Depreciacion,
                                     Num_Act_Depre = q.Num_Act_Depre,
                                     Valor_Tot_Act = q.Valor_Tot_Act,
                                     Valor_Tot_Depre = q.Valor_Tot_Depre,
                                     Valor_Tot_DepreAcum = q.Valor_Tot_DepreAcum,
                                     Valot_Tot_Importe = q.Valot_Tot_Importe
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Af_Depreciacion_Info get_info(int IdEmpresa, decimal IdDepreciacion)
        {
            try
            {
                Af_Depreciacion_Info info = new Af_Depreciacion_Info();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion Entity = Context.Af_Depreciacion.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdDepreciacion == IdDepreciacion);
                    if (Entity == null) return null;
                    info = new Af_Depreciacion_Info
                    {
                                     IdEmpresa = Entity.IdEmpresa,
                                     IdDepreciacion = Entity.IdDepreciacion,
                                     IdTipoDepreciacion = Entity.IdTipoDepreciacion,
                                     IdPeriodo = Entity.IdPeriodo,
                                     Cod_Depreciacion = Entity.Cod_Depreciacion,
                                     Descripcion = Entity.Descripcion,
                                     Estado = Entity.Estado,
                                     Fecha_Depreciacion = Entity.Fecha_Depreciacion,
                                     Num_Act_Depre = Entity.Num_Act_Depre,
                                     Valor_Tot_Act = Entity.Valor_Tot_Act,
                                     Valor_Tot_Depre = Entity.Valor_Tot_Depre,
                                     Valor_Tot_DepreAcum = Entity.Valor_Tot_DepreAcum,
                                     Valot_Tot_Importe = Entity.Valot_Tot_Importe
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    var lst = from q in Context.Af_Depreciacion
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdDepreciacion) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Depreciacion_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion Entity = new Af_Depreciacion
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdDepreciacion = info.IdDepreciacion=get_id(info.IdEmpresa),
                        IdTipoDepreciacion = info.IdTipoDepreciacion,
                        IdPeriodo = info.IdPeriodo,
                        Cod_Depreciacion = info.Cod_Depreciacion,
                        Descripcion = info.Descripcion,
                        Estado = info.Estado="A",
                        Fecha_Depreciacion = info.Fecha_Depreciacion,
                        Num_Act_Depre = info.Num_Act_Depre,
                        Valor_Tot_Act = info.Valor_Tot_Act,
                        Valor_Tot_Depre = info.Valor_Tot_Depre,
                        Valor_Tot_DepreAcum = info.Valor_Tot_DepreAcum,
                        Valot_Tot_Importe = info.Valot_Tot_Importe,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                        
                    };
                    Context.Af_Depreciacion.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(Af_Depreciacion_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion Entity = Context.Af_Depreciacion.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdDepreciacion == info.IdDepreciacion);
                    if (Entity == null) return false;

                    Entity.IdTipoDepreciacion = info.IdTipoDepreciacion;
                    Entity.IdPeriodo = info.IdPeriodo;
                    Entity.Cod_Depreciacion = info.Cod_Depreciacion;
                    Entity.Descripcion = info.Descripcion;
                    Entity.Fecha_Depreciacion = info.Fecha_Depreciacion;
                    Entity.Num_Act_Depre = info.Num_Act_Depre;
                    Entity.Valor_Tot_Act = info.Valor_Tot_Act;
                    Entity.Valor_Tot_Depre = info.Valor_Tot_Depre;
                    Entity.Valor_Tot_DepreAcum = info.Valor_Tot_DepreAcum;
                    Entity.Valot_Tot_Importe = info.Valot_Tot_Importe;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(Af_Depreciacion_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Depreciacion Entity = Context.Af_Depreciacion.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdDepreciacion == info.IdDepreciacion);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
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
