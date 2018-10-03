using Core.Erp.Info.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.ActivoFijo
{
   public class Af_Activo_fijo_Data
    {
        public List<Af_Activo_fijo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<Af_Activo_fijo_Info> Lista;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.Af_Activo_fijo
                                 join c in Context.Af_Catalogo
                                 on q.Estado_Proceso equals c.IdCatalogo
                                 where q.IdEmpresa == IdEmpresa
                                 select new Af_Activo_fijo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     Estado = q.Estado,
                                     Af_Nombre = q.Af_Nombre,
                                     IdActivoFijo = q.IdActivoFijo,
                                     Estado_Proceso = q.Estado_Proceso,
                                     Estado_Proceso_nombre = c.Descripcion,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();
                    else
                        Lista = (from q in Context.Af_Activo_fijo
                                 join c in Context.Af_Catalogo
                                 on q.Estado_Proceso equals c.IdCatalogo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new Af_Activo_fijo_Info
                                 {                                     
                                     IdEmpresa = q.IdEmpresa,
                                     Af_Nombre = q.Af_Nombre,
                                     Estado = q.Estado,
                                     IdActivoFijo = q.IdActivoFijo,
                                     Estado_Proceso = q.Estado_Proceso,
                                     Estado_Proceso_nombre = c.Descripcion,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Af_Activo_fijo_Info get_info(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                Af_Activo_fijo_Info info = new Af_Activo_fijo_Info();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdActivoFijo == IdActivoFijo);
                    if (Entity == null) return null;
                    info = new Af_Activo_fijo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        Af_Anio_fabrica = Entity.Af_Anio_fabrica,
                        Af_Codigo_Barra = Entity.Af_Codigo_Barra,
                        Af_costo_compra = Entity.Af_costo_compra,
                        Af_Costo_historico = Entity.Af_Costo_historico,
                        Af_Depreciacion_acum = Entity.Af_Depreciacion_acum,
                        Af_DescripcionCorta = Entity.Af_DescripcionCorta,
                        Af_DescripcionTecnica = Entity.Af_DescripcionTecnica,
                        Af_fecha_compra = Entity.Af_fecha_compra,
                        Af_fecha_fin_depre = Entity.Af_fecha_fin_depre,
                        Af_fecha_ini_depre = Entity.Af_fecha_ini_depre,
                        Af_foto = Entity.Af_foto,
                        Af_Meses_depreciar = Entity.Af_Meses_depreciar,
                        Af_Nombre = Entity.Af_Nombre,
                        Af_NumPlaca = Entity.Af_NumPlaca,
                        Af_NumSerie = Entity.Af_NumSerie,
                        Af_NumSerie_Chasis = Entity.Af_NumSerie_Chasis,
                        Af_NumSerie_Motor = Entity.Af_NumSerie_Motor,
                        Af_observacion = Entity.Af_observacion,
                        Af_porcentaje_deprec = Entity.Af_porcentaje_deprec,
                        Af_ValorResidual = Entity.Af_ValorResidual == null ? 0 : Convert.ToDouble(Entity.Af_ValorResidual),
                        Af_ValorSalvamento = Entity.Af_ValorSalvamento == null ? 0 : Convert.ToDouble(Entity.Af_ValorSalvamento),
                        Af_Vida_Util = Entity.Af_Vida_Util,
                        CodActivoFijo = Entity.CodActivoFijo,
                        Estado = Entity.Estado,
                        Estado_Proceso = Entity.Estado_Proceso,
                        IdActivoFijoTipo = Entity.IdActivoFijoTipo,
                        IdActivoFijo = Entity.IdActivoFijo,
                        IdCatalogo_Color = Entity.IdCatalogo_Color,
                        IdCatalogo_Marca = Entity.IdCatalogo_Marca,
                        IdCatalogo_Modelo = Entity.IdCatalogo_Modelo,
                        IdCategoriaAF = Entity.IdCategoriaAF,
                        IdSucursal = Entity.IdSucursal,
                        IdTipoCatalogo_Ubicacion = Entity.IdTipoCatalogo_Ubicacion
                        
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
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    var lst = from q in Context.Af_Activo_fijo
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdActivoFijo) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = new Af_Activo_fijo
                    {
                        IdEmpresa = info.IdEmpresa,
                        Af_Anio_fabrica = info.Af_Anio_fabrica,
                        Af_Codigo_Barra = info.Af_Codigo_Barra,
                        Af_costo_compra = info.Af_costo_compra,
                        Af_Costo_historico = info.Af_Costo_historico,
                        Af_Depreciacion_acum = info.Af_Depreciacion_acum,
                        Af_DescripcionCorta = info.Af_DescripcionCorta,
                        Af_DescripcionTecnica = info.Af_DescripcionTecnica,
                        Af_fecha_compra = info.Af_fecha_compra.Date,
                        Af_fecha_fin_depre = info.Af_fecha_fin_depre.Date,
                        Af_fecha_ini_depre = info.Af_fecha_ini_depre.Date,
                        Af_foto = info.Af_foto,
                        Af_Meses_depreciar = info.Af_Meses_depreciar,
                        Af_Nombre = info.Af_Nombre,
                        Af_NumPlaca = info.Af_NumPlaca,
                        Af_NumSerie = info.Af_NumSerie,
                        Af_NumSerie_Chasis = info.Af_NumSerie_Chasis,
                        Af_NumSerie_Motor = info.Af_NumSerie_Motor,
                        Af_observacion = info.Af_observacion,
                        Af_porcentaje_deprec = info.Af_porcentaje_deprec,
                        Af_ValorResidual = info.Af_ValorResidual,
                        Af_ValorSalvamento = info.Af_ValorSalvamento,
                        Af_Vida_Util = info.Af_Vida_Util,
                        CodActivoFijo = info.CodActivoFijo,
                        Estado = info.Estado="A",
                        Estado_Proceso = info.Estado_Proceso,
                        IdActivoFijoTipo = info.IdActivoFijoTipo,
                        IdActivoFijo = info.IdActivoFijo=get_id(info.IdEmpresa),
                        IdCatalogo_Color = info.IdCatalogo_Color,
                        IdCatalogo_Marca = info.IdCatalogo_Marca,
                        IdCatalogo_Modelo = info.IdCatalogo_Modelo,
                        IdCategoriaAF = info.IdCategoriaAF,
                        IdSucursal = info.IdSucursal,
                        IdTipoCatalogo_Ubicacion = info.IdTipoCatalogo_Ubicacion,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                        
                        
                    };
                    Context.Af_Activo_fijo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdActivoFijo == info.IdActivoFijo);
                    if (Entity == null) return false;

                    Entity.Af_Anio_fabrica = info.Af_Anio_fabrica;
                    Entity.Af_Codigo_Barra = info.Af_Codigo_Barra;
                    Entity.Af_costo_compra = info.Af_costo_compra;
                    Entity .Af_Costo_historico = info.Af_Costo_historico;
                    Entity.Af_Depreciacion_acum = info.Af_Depreciacion_acum;
                    Entity.Af_DescripcionCorta = info.Af_DescripcionCorta;
                    Entity.Af_DescripcionTecnica = info.Af_DescripcionTecnica;
                    Entity.Af_fecha_compra = info.Af_fecha_compra.Date;
                    Entity.Af_fecha_fin_depre = info.Af_fecha_fin_depre.Date;
                    Entity.Af_fecha_ini_depre = info.Af_fecha_ini_depre.Date;
                    Entity.Af_foto = info.Af_foto;
                    Entity.Af_Meses_depreciar = info.Af_Meses_depreciar;
                    Entity.Af_Nombre = info.Af_Nombre;
                    Entity.Af_NumPlaca = info.Af_NumPlaca;
                    Entity.Af_NumSerie = info.Af_NumSerie;
                    Entity.Af_NumSerie_Chasis = info.Af_NumSerie_Chasis;
                    Entity.Af_NumSerie_Motor = info.Af_NumSerie_Motor;
                    Entity.Af_observacion = info.Af_observacion;
                    Entity.Af_porcentaje_deprec = info.Af_porcentaje_deprec;
                    Entity.Af_ValorResidual = info.Af_ValorResidual;
                    Entity.Af_ValorSalvamento = info.Af_ValorSalvamento;
                    Entity.Af_Vida_Util = info.Af_Vida_Util;
                    Entity.CodActivoFijo = info.CodActivoFijo;
                    Entity.Estado_Proceso = info.Estado_Proceso;
                    Entity.IdActivoFijoTipo = info.IdActivoFijoTipo;
                    Entity.IdCatalogo_Color = info.IdCatalogo_Color;
                    Entity.IdCatalogo_Marca = info.IdCatalogo_Marca;
                    Entity.IdCatalogo_Modelo = info.IdCatalogo_Modelo;
                    Entity.IdCategoriaAF = info.IdCategoriaAF;
                    Entity.IdSucursal = info.IdSucursal;
                    Entity.IdTipoCatalogo_Ubicacion = info.IdTipoCatalogo_Ubicacion;

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

        public bool anularDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdActivoFijo == info.IdActivoFijo);
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

        public Af_Activo_fijo_valores_Info get_valores(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                Af_Activo_fijo_valores_Info valores = new Af_Activo_fijo_valores_Info();
                double v_mejora = 0;
                double v_baja = 0;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdActivoFijo == IdActivoFijo);
                    if (Entity == null) return null;

                    var mej_baj = from q in Context.Af_Mej_Baj_Activo
                                  where q.IdEmpresa == IdEmpresa
                                  && q.IdActivoFijo == IdActivoFijo
                                  select q;

                    if (mej_baj.Where(q=>q.Id_Tipo == "Mejo_Acti").Count() > 0)
                        v_mejora = mej_baj.Where(q => q.Id_Tipo == "Mejo_Acti").Sum(m => m.Valor_Mej_Baj_Activo);

                    if (mej_baj.Where(q => q.Id_Tipo == "Baja_Acti").Count() > 0)
                        v_baja = mej_baj.Where(q => q.Id_Tipo == "Baja_Acti").Sum(m => m.Valor_Mej_Baj_Activo);

                    valores = new Af_Activo_fijo_valores_Info
                    {
                        v_activo = Entity.Af_costo_compra,
                        v_depr_acum = Entity.Af_Depreciacion_acum,
                        v_baja = 0,
                        v_mejora = 0,
                        v_neto = Entity.Af_costo_compra - Entity.Af_Depreciacion_acum + v_mejora - v_baja
                    };
                }
                return valores;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
